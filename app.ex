defmodule SignUp.Plug.App do
  import Plug.Conn
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{request_path: path} = conn, opts) do
    conn
  end
end
