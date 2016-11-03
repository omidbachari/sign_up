defmodule SignUp.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/sign_up" do
    case conn |> SignUp.User.create do
      {:ok, _} ->
        send_resp(conn, 200, "success")
      _ ->
        send_resp(conn, 422, "already exists")
    end
  end

  match _, do: send_resp(conn, 404, "Oops!")
end
