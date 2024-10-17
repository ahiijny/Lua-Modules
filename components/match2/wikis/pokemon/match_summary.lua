---
-- @Liquipedia
-- wiki=pokemon
-- page=Module:MatchSummary
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local CustomMatchSummary = {}

local DateExt = require('Module:Date/Ext')
local DisplayHelper = require('Module:MatchGroup/Display/Helper')
local Icon = require('Module:Icon')
local Logic = require('Module:Logic')
local Lua = require('Module:Lua')
local Table = require('Module:Table')
local ExternalLinks = require('Module:ExternalLinks')
local String = require('Module:StringUtils')
local Array = require('Module:Array')
local Abbreviation = require('Module:Abbreviation')

local MatchSummary = Lua.import('Module:MatchSummary/Base')
local MatchSummaryWidgets = Lua.import('Module:Widget/Match/Summary/All')

local MAX_NUM_BANS = 5
local NUM_CHAMPIONS_PICK = 5
local NO_CHARACTER = 'default'

local GREEN_CHECK = Icon.makeIcon{iconName = 'winner', color = 'forest-green-text', size = '110%'}
local NO_CHECK = '[[File:NoCheck.png|link=]]'

---@param args table
---@return Html
function CustomMatchSummary.getByMatchId(args)
	return MatchSummary.defaultGetByMatchId(CustomMatchSummary, args, {width = '420px', teamStyle = 'bracket'})
end

---@param match MatchGroupUtilMatch
---@param footer MatchSummaryFooter
---@return MatchSummaryFooter
function CustomMatchSummary.addToFooter(match, footer)
	footer = MatchSummary.addVodsToFooter(match, footer)

	if Table.isNotEmpty(match.links) then
		footer:addElement(ExternalLinks.print(match.links))
	end

	return footer
end

---@param match MatchGroupUtilMatch
---@return MatchSummaryBody
function CustomMatchSummary.createBody(match)
	local body = MatchSummary.Body()

	if match.dateIsExact or match.timestamp ~= DateExt.defaultTimestamp then
		-- dateIsExact means we have both date and time. Show countdown
		-- if match is not default date, we have a date, so display the date
		body:addRow(MatchSummary.Row():addElement(
			DisplayHelper.MatchCountdownBlock(match)
		))
	end

	-- Iterate each map
	for gameIndex, game in ipairs(match.games) do
		local rowDisplay = CustomMatchSummary._createGame(game, gameIndex, match.date)
		if rowDisplay then
			body:addRow(rowDisplay)
		end
	end

	-- Add Match MVP(s)
	if Table.isNotEmpty(match.extradata.mvp) then
		body.root:node(MatchSummaryWidgets.Mvp{
			players = match.extradata.mvp.players,
			points = match.extradata.mvp.points,
		})
	end

	-- Add the Character Bans
	local characterBansData = MatchSummary.buildCharacterBanData(match.games, MAX_NUM_BANS, NO_CHARACTER)
	if characterBansData then
		body.root:node(MatchSummaryWidgets.CharacterBanTable{
			bans = characterBansData,
			date = match.date,
		})
	end

	return body
end

---@param game MatchGroupUtilGame
---@param gameIndex integer
---@param date string
---@return MatchSummaryRow?
function CustomMatchSummary._createGame(game, gameIndex, date)
	local row = MatchSummary.Row()
	local extradata = game.extradata or {}

	local getChampsForTeam = function(team)
		local getChampFromIndex = function(champIndex)
			return champIndex, String.nilIfEmpty(extradata['team' .. team .. 'champion' .. champIndex])
		end
		return Table.map(Array.range(1, NUM_CHAMPIONS_PICK), getChampFromIndex)
	end
	local championsData = Array.map(Array.range(1, 2), getChampsForTeam)--[[@as table]]
	local championsDataIsEmpty = Array.all(championsData, Table.isEmpty)
	championsData[1].color = extradata.team1side
	championsData[2].color = extradata.team2side

	if Table.isEmpty(game.scores) and Logic.isEmpty(game.winner) and championsDataIsEmpty then
		return nil
	end

	row	:addClass('brkts-popup-body-game')
		:css('font-size', '85%')
		:css('overflow', 'hidden')

	local score
	if not Table.isEmpty(game.scores) then
		score = table.concat(game.scores, '-')
	end

	row:addElement(MatchSummaryWidgets.Characters{
		flipped = false,
		date = date,
		characters = championsData[1],
		bg = 'brkts-popup-side-color-' .. (extradata.team1side or ''),
	})
	row:addElement(CustomMatchSummary._createCheckMark(game.winner == 1))
	row:addElement(mw.html.create('div')
		:addClass('brkts-popup-body-element-vertical-centered')
		:wikitext(Abbreviation.make(
			score or ('Game ' .. gameIndex),
			Logic.isEmpty(game.length) and ('Game ' .. gameIndex .. ' picks') or 'Map Scores'
		))
	)
	row:addElement(CustomMatchSummary._createCheckMark(game.winner == 2))
	row:addElement(MatchSummaryWidgets.Characters{
		flipped = true,
		date = date,
		characters = championsData[2],
		bg = 'brkts-popup-side-color-' .. (extradata.team2side or ''),
	})

	-- Add Comment
	if not Logic.isEmpty(game.comment) then
		row:addElement(MatchSummary.Break():create())
		local comment = mw.html.create('div')
		comment :wikitext(game.comment)
				:css('margin', 'auto')
		row:addElement(comment)
	end

	return row
end

---@param isWinner boolean?
---@return Html
function CustomMatchSummary._createCheckMark(isWinner)
	local container = mw.html.create('div')
		:addClass('brkts-popup-spaced')
		:css('line-height', '27px')
		:css('margin-left', '3%')
		:css('margin-right', '3%')

	if isWinner then
		container:node(GREEN_CHECK)
	else
		container:node(NO_CHECK)
	end

	return container
end

return CustomMatchSummary
