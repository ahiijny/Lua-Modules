---
-- @Liquipedia
-- wiki=dota2
-- page=Module:MainPageLayout/data
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local CONTENT = {
	aboutMain = {
		heading = 'About Liquipedia’s Dota 2 Wiki',
		body = 'We are the largest Dota 2 wiki that anyone can edit, maintained by fans just like you. ' ..
			'This wiki currently covers esports and game content, containing over {{NUMBEROFARTICLES}} ' ..
			'articles managed by {{NUMBEROFACTIVEUSERS}} active users.' ..
			'<div style="display:flex; flex-wrap: wrap; gap:12px; justify-content:center; padding-top: 12px;">' ..
			'{{button|text=View Esports Hub|title=Click here to get to the esports hub|internallink=Portal:Esports' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'{{button|text=View Game Hub|title=Click here to get to the game hub|internallink=Portal:Game' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'</div>',
		padding = true,
		boxid = 1500,
	},
	aboutEsport = {
		heading = 'About Liquipedia’s Dota 2 Wiki',
		body = 'We are the largest Dota 2 wiki that anyone can edit, maintained by fans just like you. ' ..
			'This wiki currently covers esports and game content, containing over {{NUMBEROFARTICLES}} ' ..
			'articles managed by {{NUMBEROFACTIVEUSERS}} active users.' ..
			'<div style="display:flex; flex-wrap: wrap; gap:12px; justify-content:center; padding-top: 12px;">' ..
			'{{button|text=View Main Page|title=Click here to get to the main page|internallink=Main_Page' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'{{button|text=View Game Hub|title=Click here to get to the game hub|internallink=Portal:Game' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'</div>',
		padding = true,
		boxid = 1500,
	},
	aboutGame = {
		heading = 'About Liquipedia’s Dota 2 Wiki',
		body = 'We are the largest Dota 2 wiki that anyone can edit, maintained by fans just like you. ' ..
			'This wiki currently covers esports and game content, containing over {{NUMBEROFARTICLES}} ' ..
			'articles managed by {{NUMBEROFACTIVEUSERS}} active users.' ..
			'<div style="display:flex; flex-wrap: wrap; gap:12px; justify-content:center; padding-top: 12px;">' ..
			'{{button|text=View Main Page|title=Click here to get to the main page|internallink=Main_Page' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'{{button|text=View Esports Hub|title=Click here to get to the esports hub|internallink=Portal:Esports' ..
			'|icon=fa-external-link-alt wiki-color-dark|new=true|secondary=true}}' ..
			'</div>',
		padding = true,
		boxid = 1500,
	},
	heroes = {
		heading = 'Heroes',
		body = '<div class="heroes-panel" data-component="heroes-panel">{{HeroTable}}</div>',
		padding = true,
		boxid = 1501,
	},
	updates = {
		heading = 'Updates',
		body = '<nowiki>\n</nowiki>{{Main Page Updates}}',
		padding = true,
		boxid = 1502,
	},
	usefulArticles = {
		heading = 'Useful Articles',
		body = '{{Main Page Useful Articles}}',
		padding = true,
		boxid = 1503,
	},
	wantToHelp = {
		heading = 'Want To Help?',
		body = '{{Liquipedia:Want_to_help}}',
		padding = true,
		boxid = 1504,
	},
	transfers = {
		heading = 'Transfers',
		body = '{{Transfer List|limit=15}}\n' ..
			'<div style{{=}}"display:block; text-align:center; padding:0.5em;">\n' ..
			'\t<div style{{=}}"display:inline; float:left; font-style:italic;">\'\'[[#Top|Back to top]]\'\'</div>\n' ..
			'\t<div style{{=}}"display:inline; float:right;" class="plainlinks smalledit">' ..
			'&#91;[{{FULLURL:Transfers/{{Current term}}|action=edit}} edit]&#93;</div>\n' ..
			'\t<div style{{=}}"white-space:nowrap; display:inline; margin:0 10px; font-size:15px; font-style:italic;">' ..
			'[[Portal:Transfers|See more transfers]]' ..
			'<span style="font-style:normal; padding:0 5px;">&#8226;</span>[[Transfer query]]' ..
			'<span style{{=}}"font-style:normal; padding:0 5px;">&#8226;</span>' ..
			'[[lpcommons:Special:RunQuery/Transfer|Input Form]]</div>\n' ..
			'</div>',
		boxid = 1509,
	},
	thisDay = {
		heading = 'This day in Dota <small id="this-day-date" style = "margin-left: 5px">' ..
			'({{#time:F}} {{Ordinal|{{#time:j}}}})</small>',
		body = '{{Liquipedia:This day}}',
		padding = true,
		boxid = 1510,
	},
	specialEvents = {
		noPanel = true,
		body = '{{Liquipedia:Special Event}}',
	},
	filterButtons = {
		noPanel = true,
		body = '<div style{{=}}"width:100%;margin-bottom:8px;">' ..
		'{{#invoke:Lua|invoke|module=FilterButtons|fn=getFromConfig}}</div>',
	},
	matches = {
		heading = 'Matches',
		body = '{{NewDota2MainPage_matches}}' ..
			'<div style{{=}}"white-space:nowrap; display: block; margin:0 10px; font-size:15px; ' ..
			'font-style:italic; text-align:center;">[[Liquipedia:Matches|See more matches]]</div>',
		padding = true,
		boxid = 1507,
	},
	tournaments = {
		heading = 'Tournaments',
		body = '{{NewDota2MainPage_tournaments}}',
		padding = true,
		boxid = 1508,
	},
}

return {
	main = {
		{ -- Left
			size = 6,
			children = {
				{
					mobileOrder = 1,
					content = CONTENT.aboutMain,
				},
				{
					mobileOrder = 4,
					content = CONTENT.heroes,
				},
				{
					mobileOrder = 5,
					content = CONTENT.updates,
				},
				{
					mobileOrder = 9,
					content = CONTENT.usefulArticles,
				},
				{
					mobileOrder = 7,
					content = CONTENT.wantToHelp,
				},
			},
		},
		{ -- Right
			size = 6,
			children = {
				{
					mobileOrder = 2,
					content = CONTENT.specialEvents
				},
				{
					mobileOrder = 3,
					children = {
						{
							children = {
								{
									noPanel = true,
									content = CONTENT.filterButtons,
								},
							},
						},
						{
							size = 6,
							children = {
								{
									noPanel = true,
									content = CONTENT.matches,
								},
							},
						},
						{
							size = 6,
							children = {
								{
									noPanel = true,
									content = CONTENT.tournaments,
								},
							},
						},
					},
				},
				{
					mobileOrder = 6,
					content = CONTENT.transfers,
				},
				{
					mobileOrder = 9,
					content = CONTENT.thisDay,
				},
			},
		},
	},
	esports = {
		{ -- Left
			size = 6,
			children = {
				{
					mobileOrder = 1,
					content = CONTENT.aboutEsport,
				},
				{
					mobileOrder = 2,
					content = CONTENT.specialEvents,
				},
				{
					mobileOrder = 4,
					content = CONTENT.transfers,
				},
				{
					mobileOrder = 6,
					content = CONTENT.thisDay,
				},
				{
					mobileOrder = 7,
					content = CONTENT.wantToHelp,
				},
			}
		},
		{ -- Right
			size = 6,
			children = {
				{
					mobileOrder = 3,
					children = {
						{
							children = {
								{
									noPanel = true,
									content = CONTENT.filterButtons,
								},
							},
						},
						{
							size = 6,
							children = {
								{
									noPanel = true,
									content = CONTENT.matches,
								},
							},
						},
						{
							size = 6,
							children = {
								{
									noPanel = true,
									content = CONTENT.tournaments,
								},
							},
						},
					},
				},
				{
					mobileOrder = 5,
					content = CONTENT.updates,
				},
			},
		},
	},
	game = {
		{ -- Left
			size = 6,
			children = {
				{
					mobileOrder = 1,
					content = CONTENT.aboutGame,
				},
				{
					mobileOrder = 2,
					content = CONTENT.heroes,
				},
				{
					mobileOrder = 6,
					content = CONTENT.wantToHelp,
				},
			},
		},
		{ -- Right
			size = 6,
			children = {
				{
					mobileOrder = 3,
					content = CONTENT.updates
				},
				{
					mobileOrder = 4,
					content = CONTENT.thisDay,
				},
				{
					mobileOrder = 5,
					content = CONTENT.usefulArticles,
				},
			},
		},
	},
}