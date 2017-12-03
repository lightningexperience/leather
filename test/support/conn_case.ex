defmodule LeatherWeb.ConnCase do
  @moduledoc "This module defines the test case to be used by\ntests that require setting up a connection.\n\nSuch tests rely on `Phoenix.ConnTest` and also\nimport other functionality to make it easier\nto build common datastructures and query the data layer.\n\nFinally, if the test case interacts with the database,\nit cannot be async. For this reason, every test runs\ninside a transaction which is reset at the beginning\nof the test unless the test case is marked as async.\n"

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      import LeatherWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint LeatherWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Leather.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Leather.Repo, {:shared, self()})
    end

    {:ok, [conn: Phoenix.ConnTest.build_conn()]}
  end
end
