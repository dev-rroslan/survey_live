defmodule SurveyLive.Admins.Guardian do
  @moduledoc """
  This module is used by Guardian for decoding and loading the admin.
  Used before SurveyLiveWeb.Plugs.SetCurrentAdmin
  """
  use Guardian, otp_app: :survey_live

  alias SurveyLive.Admins

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    admin = Admins.get_admin!(id)

    {:ok, admin}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
