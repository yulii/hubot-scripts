class QueryString

  @build: (params) ->
    return Object.keys(params).map((k) -> encodeURIComponent(k) + '=' + encodeURIComponent(params[k])).join('&')

module.exports = QueryString
