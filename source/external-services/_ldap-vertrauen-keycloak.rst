.. attention::

   **Vertrauen bei direkter LDAP-Anbindung**

   Bei einer direkten LDAP-Anbindung gibt der Bind-User zwar keine Nutzerpasswörter preis, wohl aber geben die
   Nutzer/innen selbst ihr AD-Passwort direkt auf der Weboberfläche des externen Dienstes ein. Diesem Dienst
   (bzw. dessen Betreiber) muss man also entsprechend vertrauen, da er potenziell an die eingegebenen
   Zugangsdaten gelangen könnte.

   Steht stattdessen ein Keycloak zur Verfügung (z.B. bei Edulution bereits integriert, oder selbst betrieben
   und an die linuxmuster.net angebunden), ist es aus Datenschutz-/Sicherheitssicht vorzuziehen, Dienste über
   Keycloak per SSO (OIDC/SAML) statt per direktem LDAP-Bind anzubinden: Die Passwörter/Secrets der Nutzer/innen
   verbleiben dann stets auf der eigenen Infrastruktur und werden dem externen Dienst nie direkt mitgeteilt.
