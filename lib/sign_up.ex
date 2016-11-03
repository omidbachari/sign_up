defmodule SignUp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:sign_up, :cowboy_port)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, SignUp.Router, [], [port: port]),
      supervisor(Task.Supervisor, [[name: SignUp.CreateSup, restart: :transient]], id: :create)
    ]

    opts = [strategy: :one_for_one, name: SignUp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
