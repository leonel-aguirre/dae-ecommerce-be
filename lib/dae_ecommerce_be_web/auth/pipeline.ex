defmodule DaeEcommerceBeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :dae_ecommerce_be,
    module: DaeEcommerceBeWeb.Auth.Guardian,
    error_handler: DaeEcommerceBeWeb.Auth.GuardianErrorHandler

  # Looks for token in session.
  plug Guardian.Plug.VerifySession
  # Looks for token in header.
  plug Guardian.Plug.VerifyHeader
  # Ensure a token is found.
  plug Guardian.Plug.EnsureAuthenticated
  # Attempt to load resource.
  plug Guardian.Plug.LoadResource

  # If errors an authenticated error will be triggered.
end
