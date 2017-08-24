class CircleCI

  constructor: (args) ->
    @vcsType = args.vcsType ? 'github'
    @owner   = args.owner
    @project = args.project
    @branch  = args.branch ? 'master'
    @job     = args.job
    @token   = args.token ? @tokenEnvValue()
    _assert.call @

  tokenEnvName: ->
    _tokenEnvName = "CIRCLE_TOKEN_#{@project.replace(/[-.]/gi, '_').toUpperCase()}" unless _tokenEnvName?
    return _tokenEnvName

  tokenEnvValue: ->
    _tokenEnvValue = process.env[@tokenEnvName()] unless _tokenEnvValue?
    return _tokenEnvValue

  endpoint: ->
    _endpoint = "https://circleci.com/api/v1.1/project/#{@vcsType}/#{@owner}/#{@project}/tree/#{@branch}" unless _endpoint?
    return _endpoint

  notify: (destination) ->
    @destination = destination
    return @

  execute: (robot) ->
    params = JSON.stringify
                build_parameters:
                  CIRCLE_JOB: @job
                  JOB_USER: robot.name

    robot.http("#{@endpoint()}?circle-token=#{@token}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .post(params) (error, response, body) ->

        if error
          robot.send { room: @destination }, "Encountered an error :( `#{error}`"
          return

        if response.statusCode < 200 or response.statusCode >= 300
          robot.send { room: @destination }, "Request fail :( `#{response.statusCode}: #{response.statusMessage}`"
          return

        result = JSON.parse(body)
        robot.send { room: @destination }, "Created a new build! #{result.build_url}"

  _assert = ->
    throw new Error('`owner` is required argument')   unless @owner?
    throw new Error('`project` is required argument') unless @project?
    throw new Error('`job` is required argument')     unless @job?
    throw new Error("Access token not found! `token` is not specified in arguments or environment variable `#{@tokenEnvName()}` is undefined.") unless @token?

module.exports = CircleCI
