defmodule SurveyLive.Admins.ErrorHandlerTest do
  use SurveyLiveWeb.ConnCase, async: true

  alias SurveyLive.Admins.ErrorHandler

  test "returns http status 401 to the conn" do
    conn =
      build_conn()
      |> ErrorHandler.auth_error({"Unauthorized", nil}, [])

    assert conn.status == 401
    assert conn.resp_body =~ "Unauthorized"
  end
end
