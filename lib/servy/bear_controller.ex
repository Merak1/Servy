defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear

  defp bear_item(bear) do
    "<li>Name: #{bear.name}  - #{bear.type} </li> \n"
  end
  def index(conv) do
    bears = Wildthings.list_bears()
    # |> Enum.filter(fn bear -> Bear.is_grizzly(bear) end)
    |> Enum.filter(&Bear.is_grizzly(&1))
    # |> Enum.sort(fn (b1, b2) -> Bear.order_asc_by_name(b1, b2) end)
    |> Enum.sort(&Bear.order_asc_by_name(&1,&2))
    # |> Enum.map( fn bear -> bear_item(bear) end)
    # |> Enum.map( &bear_item(&1))
    |> Enum.map( &bear_item/1)
    |> Enum.join()

    Servy.Helpers.blue(bears)

    %{conv | status: 200, resp_body: "<ul> #{bears} </ul>"}
  end
  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "Bear #{bear.name}: type -> #{bear.type}"}
  end
  def create(conv, %{"type" => type , "name" => name} ) do
      %{conv | status: 201,
     resp_body: "Created a #{type} bear named #{name}"}

  end

  def delete(conv, _params) do
    %{conv | status: 403, resp_body: "You cannot delete"}
  end
end
