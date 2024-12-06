---
-- @Liquipedia
-- wiki=freefire
-- page=Module:GetMatchGroupCopyPaste/wiki
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local Array = require('Module:Array')
local Class = require('Module:Class')
local Lua = require('Module:Lua')

local OpponentLibraries = require('Module:OpponentLibraries')
local Opponent = OpponentLibraries.Opponent

local BaseCopyPaste = Lua.import('Module:GetMatchGroupCopyPaste/wiki/Base')

---WikiSpecific Code for MatchList and Bracket Code Generators
---@class FreefireMatchCopyPaste: Match2CopyPasteBase
local WikiCopyPaste = Class.new(BaseCopyPaste)

local INDENT = WikiCopyPaste.Indent

---returns the Code for a Match, depending on the input
---@param bestof integer
---@param mode string
---@param index integer
---@param opponents integer
---@param args table
---@return string
function WikiCopyPaste.getMatchCode(bestof, mode, index, opponents, args)
	local lines = Array.extend(
		'{{Match|finished=',
		INDENT .. '|p_kill=1 |p1=12 |p2=9 |p3=8 |p4=7 |p5=6 |p6=5 |p7=4 |p8=3 |p9=2 |p10=1 |p11=0 |p12=0',
		{INDENT .. '|twitch=|youtube='},
		Array.map(Array.range(1, bestof), function(mapIndex)
			return INDENT .. '|map' .. mapIndex .. '={{Map|date=|finished=|map=|vod=}}'
		end),
		Array.map(Array.range(1, opponents), function(opponentIndex)
			return INDENT .. '|opponent' .. opponentIndex .. '=' .. WikiCopyPaste._getOpponent(mode, bestof)
		end),
		'}}'
	)

	return table.concat(lines, '\n')
end

--subfunction used to generate the code for the Opponent template, depending on the type of opponent
---@param mode string
---@param mapCount integer
---@return string
function WikiCopyPaste._getOpponent(mode, mapCount)
	local mapScores = table.concat(Array.map(Array.range(1, mapCount), function(idx)
		return '|m' .. idx .. '={{MS||}}'
	end))

	if mode == Opponent.solo then
		return '{{SoloOpponent||flag=' .. mapScores .. '}}'
	elseif mode == Opponent.team then
		return '{{TeamOpponent|' .. mapScores .. '}}'
	elseif mode == Opponent.literal then
		return '{{Literal|' .. mapScores .. '}}'
	end

	return ''
end

return WikiCopyPaste