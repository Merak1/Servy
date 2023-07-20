
defmodule Servy.Handler do

  # @pages_path  Path.expand("../../pages", __DIR__)
  @pages_path Path.expand("pages", File.cwd!)

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.HandleFile
  import Servy.Helpers

  alias Servy.Conv
  alias Servy.BearController


  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{method: "GET" , path: "/wildthings"} = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET" , path: "/pages"<> page_subdomain } = conv) do
      @pages_path
    |> Path.join(page_subdomain <> ".html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET" , path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end
  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    BearController.create(conv, conv.params)
  end

  def route(%Conv{method: "GET" , path: "/bears"} = conv) do
    BearController.index(conv)
  end

  def route(%Conv{method: "GET" , path: "/bears"<> id } = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  # name=Baloo&type=Brown


  def route(%Conv{method: "GET" , path: "/bears/new" } = conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end


  def route(%Conv{method: "DELETE" } = conv) do
    BearController.delete(conv, conv.params)
  end

  def route(%Conv{ path: path } = conv) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end



  def format_response(%Conv{ } = conv) do

  """
  HTTP/1.1 #{Conv.full_status(conv)}\r
  Content-Type: text/html\r
  Content-Length: #{String.length(conv.resp_body)}\r
  \r
  #{conv.resp_body}
  """
  end

end


  # Servy.Helpers.custom_log_servy_handler(request1)
  # Servy.Helpers.custom_log_servy_handler(request2)
  # Servy.Helpers.custom_log_servy_handler(request3)
  # Servy.Helpers.custom_log_servy_handler(request4)
  # Servy.Helpers.custom_log_servy_handler(request5)
  # Servy.Helpers.custom_log_servy_handler(request6)
  # Servy.Helpers.custom_log_servy_handler(request7)
  # Servy.Helpers.custom_log_servy_handler(request8)
  # Servy.Helpers.custom_log_servy_handler(request9)
  # Servy.Helpers.custom_log_servy_handler(request10)
  # Servy.Helpers.custom_log_servy_handler(request11)
