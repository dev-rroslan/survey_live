defmodule SurveyLiveWeb.Views.AppInfo do
  @moduledoc """
  Convenience functions for displaying company info.
  """
  use Ecto.Schema

  embedded_schema do
    field :app_name, :string, default: Application.get_env(:survey_live, :app_name)
    field :page_url, :string, default: Application.get_env(:survey_live, :page_url)
    field :company_name, :string, default: Application.get_env(:survey_live, :company_name)
    field :company_address, :string, default: Application.get_env(:survey_live, :company_address)
    field :company_zip, :string, default: Application.get_env(:survey_live, :company_zip)
    field :company_city, :string, default: Application.get_env(:survey_live, :company_city)
    field :company_state, :string, default: Application.get_env(:survey_live, :company_state)
    field :company_country, :string, default: Application.get_env(:survey_live, :company_country)
    field :contact_name, :string, default: Application.get_env(:survey_live, :contact_name)
    field :contact_phone, :string, default: Application.get_env(:survey_live, :contact_phone)
    field :contact_email, :string, default: Application.get_env(:survey_live, :contact_email)
  end

  def info do
    %__MODULE__{}
  end

  def app_name, do: info().app_name

  def page_url, do: info().page_url

  def company_name, do: info().company_name

  def address, do: info().company_address

  def zip, do: info().company_zip

  def city, do: info().company_city
end
