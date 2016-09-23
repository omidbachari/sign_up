defmodule SignUp.User do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      supervisor(Task.Supervisor, [[name: SignUp.AnalyticsSup, restart: :transient]], id: :analytics),
      supervisor(Task.Supervisor, [[name: SignUp.MailerSup, restart: :transient]], id: :mailer)
    ]
    supervise(children, strategy: :one_for_one)
  end

  def create(conn) do
    __MODULE__.start_link()
    Task.Supervisor.async(SignUp.CreateSup, fn ->
      case conn |> Plug.Conn.read_body |> elem(1) |> valid? do
        {:ok, user} ->
          user |> persist |> onboard
        _ -> :error
      end
    end) |> Task.await
  end

  defp valid?(user) do
    {:ok, user}
  end

  defp persist(user) do
    user
  end

  defp onboard(user) do
    Task.Supervisor.start_child SignUp.AnalyticsSup, fn ->
      user |> log_analytics
    end

    Task.Supervisor.start_child SignUp.MailerSup, fn ->
      user |> dispatch_welcome_email
    end
  end

  defp log_analytics(user) do
    user
  end

  defp dispatch_welcome_email(user) do
    user
  end
end
