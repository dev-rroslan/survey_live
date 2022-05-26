defmodule SurveyLiveWeb.Live.UserAuth do
  @moduledoc """
  Assigns current_user on the liveview socket
  """

  import Phoenix.LiveView
  alias SurveyLive.Users

  def on_mount(:default, _params, %{"user_token" => token}, socket) when is_binary(token) do
    case Users.get_user_by_session_token(token) do
      %{} = user ->
        # user = Accounts.with_account(user)
        {
          :cont,
          socket
          # |> assign(:account, user.account)
          |> assign(:current_user, user)
        }
      _ ->
        {:halt, redirect(socket, to: "/sign_in")}
    end
  end

  def on_mount(:default, _params, _session, socket) do
    {:halt, redirect(socket, to: "/sign_in")}
  end
end
