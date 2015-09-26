require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"

Cuba.use Rack::Session::Cookie, key: "offers-loader-session", secret: "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

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
      render("results")
    end
  end
end
