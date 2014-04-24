'use strict'

facs = angular.module 'coretracker.factories', []

facs.factory 'TasksModel', () ->
	@taskGroups = [
			id: 1
			name: "My Business Tasks"
		,
			id: 2
			name: "My Tasks"
	]

	@type = 'daily'

	@dailyTasks = [
			group: @taskGroups[0]
			tasks: [
					id: 1
					title: "Call 1 prospect"
					toolTip: "Use my contacts list and call 1 person per day."
					occurenciesNumber: 1
					occuredCount: 0
				,
					id: 26
					title: "Call 2 prospect"
					toolTip: "Use my contacts list and call 2 person per day."
					occurenciesNumber: 1
					occuredCount: 0
			]
		,
			group: @taskGroups[1]
			tasks: [
					id: 25
					title: "Cook dinner"
					toolTip: "Use my contacts list and Cook dinner."
					occurenciesNumber: 2
					occuredCount: 1
				,
					id: 4
					title: "Clean house"
					toolTip: "Use my contacts list and clean house."
					occurenciesNumber: 3
					occuredCount: 0
			]
	]

	@weeklyTasks = [
			group: @taskGroups[0]
			tasks: [
				id: 5
				title: "Show the plan"
				toolTip: "Face to face meeting where I show the plan to prospect"
				occurenciesNumber: 2
				occuredCount: 0
			]
		,
			group: @taskGroups[1]
			tasks: [
				id: 6
				title: "Wash the car"
				toolTip: "Face to face meeting where I wash the car"
				occurenciesNumber: 2
				occuredCount: 0
			]
	]

	@monthlyTasks = [
			group: @taskGroups[0]
			tasks: []
		,
			group: @taskGroups[1]
			tasks: []
	]

	@tasks = []
	#
	@getTasksFromTo = (type) =>
    	switch type
    		when 'daily' then @tasks = @dailyTasks
    		when 'weekly' then @tasks = @weeklyTasks
    		when 'monthly' then @tasks = @monthlyTasks

    return @