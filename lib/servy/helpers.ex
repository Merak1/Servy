defmodule Servy.Helpers do
  def custom_log_servy_handler(request) do
       IO.puts(Servy.Handler.handle(request))
  end

   def red(element) do
     IO.ANSI.red_background() <> "#{element}" <> IO.ANSI.reset()
     |> IO.puts()
   end

   def green(element) do
      IO.ANSI.green_background() <> "#{element}" <> IO.ANSI.reset()
      |> IO.puts()
  end

   def blue(element) do
      IO.ANSI.blue_background() <> "#{element}" <> IO.ANSI.reset()
      |> IO.puts()  end
   def magenta(element) do
      IO.ANSI.magenta_background() <> "#{element}" <> IO.ANSI.reset()
      |> IO.puts()
   end
   def yellow(element) do
      IO.ANSI.yellow_background() <> "#{element}" <> IO.ANSI.reset()
      |> IO.puts()
   end

   def red_map(element)do
      IO.ANSI.red_background() <>"#{inspect(element)}" <> IO.ANSI.reset()
      |>
      IO.puts()
  end

end
