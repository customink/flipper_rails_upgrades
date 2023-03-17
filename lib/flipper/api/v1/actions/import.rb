require 'flipper/exporters/json/export'
require 'flipper/api/action'
require 'flipper/api/v1/decorators/feature'

module Flipper
  module Api
    module V1
      module Actions
        class Import < Api::Action
          route %r{\A/import/?\Z}

          def post
            body = request.body.read
            request.body.rewind
            export = Flipper::Exporters::Json::Export.new(input: body)
            flipper.import(export)
            json_response({}, 200)
          rescue JSON::ParserError
            json_error_response(:import_invalid)
          end
        end
      end
    end
  end
end
