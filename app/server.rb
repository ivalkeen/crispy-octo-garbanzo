#
# Application entry point

$LOAD_PATH.unshift("./app")

require "cuba"
require "cuba/safe"
require "cuba/render"
require "cuba/contrib"
require "tilt/erb"
require "erb"

require "config"
require "fyber_gateway"

Cuba.use Rack::Session::Cookie, key: "offers-loader-session", secret: Config::SECRET

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render
Cuba.plugin Cuba::Prelude

Cuba.settings[:render][:template_engine] = "erb"
Cuba.settings[:render][:views] = "app/views/"

Cuba.define do
  on csrf.unsafe? do
    csrf.reset!

    res.status = 403
    res.write("Not authorized")

    halt(res.finish)
  end

  on get do
    on root do
      render("form")
    end
  end

  on post do
    on root do
      # validate presence of `uid` only, because `page` and `pub0` are not require according
      # to documentation
      on param("uid") do |uid|
        @current_page = req.POST["page"].to_i

        params = Config::DEFAULT_PARAMS.merge(
          timestamp: Time.now.utc.to_i,
          uid: uid,
          page: @current_page,
          pub0: req.POST["pub0"],
        )

        begin
          @offers_response = FyberGateway.new(params, Config::API_KEY).load_offers
          render("results")
        rescue FyberGateway::SignatureInvalidError => e
          @error = e.message
          render("form")
        rescue FyberGateway::ResponseInvalidError => e
          @error = "Server responded with error: #{e.message}"
          render("form")
        end
      end

      on true do
        @error = "Please, provide UID"
        render("form")
      end
    end
  end
end
