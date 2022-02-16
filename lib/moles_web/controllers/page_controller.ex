defmodule MolesWeb.PageController do
  use MolesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
