defmodule Servy.Plugins do
  alias Servy.Conv
  import Servy.Helpers
  def track(%Conv{status: 200, path: path} = conv ) do
    green( "Success#{path},")
  conv
end

def track(%Conv{status: 404, path: path} = conv ) do
    red("Waring: #{path}, not found")
  conv
end
def track(%Conv{status: 403, path: path} = conv ) do
   magenta("Forbiden path: #{path} |  Status : #{403} ")
  conv
end
def track(%Conv{} = conv), do: conv

def rewrite_path( %Conv{path: "/wildlife"} = conv ) do
  %{conv | path: "/wildthings"}
end

def rewrite_path( %Conv{path: "/bears?id=" <> id} = conv ) do
  # IO.puts(" 🧡 #{id}")
  %{conv | path: "/bears/" <> id}
end

def rewrite_path( %Conv{} = conv ), do: conv


def log(%Conv{} = conv), do: IO.inspect conv

end
