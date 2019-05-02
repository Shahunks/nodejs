consul {
  address="http://ngmesa1.imanagelabs.dev:8500"
}
vault {
  address="http://ngmesa1.imanagelabs.dev:8200"
  token="s.Uo0TL1uys3qeHRQQEvqj9qwT"
  renew_token = false

}

template {
    source      = "./db.tpl"
    destination = "./config.json"

}

