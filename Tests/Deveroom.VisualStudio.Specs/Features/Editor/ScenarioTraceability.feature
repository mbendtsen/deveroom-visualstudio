﻿@wip
Feature: Scenario traceability

Allow opening artifacts related to scenarios in browser, based on configured 
tags that match to a specific pattern.

E.g: tag @issue:1234 can be linked to a GitHub issue, like https://github.com/specsolutions/my-project/issues/1234.
For this, the tag pattern (Regex) has to be defined as 
	issue\:(?<id>\d+)
and the URL template as
	https://github.com/specsolutions/my-project/issues/{id}

Scenario: Turns configured tag to a link
	Given there is a SpecFlow project scope
	And the project configuration file contains
		"""
		"traceability": {
			"tagLinks": [
				{
					"tagPattern": "issue\\:(?<id>\\d+)",
					"urlTemplate": "https://github.com/specsolutions/my-project/issues/{id}"
				}
			]
		}
		"""
	When the following feature file is opened in the editor
		"""
		Feature: Addition

		@issue:1234
		Scenario: Add two numbers
			When I press add
		"""
	Then all Tag section should be highlighted as
		"""
		Feature: Addition

		{Tag}@issue:1234{/Tag}
		Scenario: Add two numbers
			When I press add
		"""
	And the tag links should target to the following URLs
		| tag         | url                                                     |
		| @issue:1234 | https://github.com/specsolutions/my-project/issues/1234 |