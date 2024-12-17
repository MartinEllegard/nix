{ ... }:

let
  username = "martin";
in
{
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };
}
