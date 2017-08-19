class CircleCI

  _apiUrl = 'https://circleci.com/api/v1.1'

  constructor: (args) ->
    @vcsType = args.vcsType ? 'github'
    @owner   = args.owner
    @project = args.project
    @branch  = args.branch ? 'master'
    @token   = args.token
    @job     = args.job

  notify: (destination) ->
    @destination = destination
    return @

  execute: (robot) ->
    params = JSON.stringify
                build_parameters:
                  CIRCLE_JOB: @job
                  JOB_USER: robot.name

    robot.http("#{_apiUrl}/project/#{@vcsType}/#{@owner}/#{@project}/tree/#{@branch}?circle-token=#{@token}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .post(params) (error, response, body) ->

        if error
          robot.send { room: @destination }, "Encountered an error :( `#{error}`"
          return

        if response.statusCode < 200 or response.statusCode >= 300
          robot.send { room: @destination }, "Request fail :( `#{response.statusCode}: #{response.statusMessage}`"
          return

        try
          result = JSON.parse(body)
          robot.send { room: @destination }, "Created a new build! #{result.build_url}"
        catch error
          console.error(error.message)

module.exports = CircleCI
