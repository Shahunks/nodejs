{
    "customerDB": {
        "mongo": {
                                          {{ with secret "kv/my-secret" }}
            "customerDB": "{{ .Data.var }}{{ end }}/customerDB"

        }
    },
    "pods": {
        "pod1": {
            "mongo": {
                                         {{ with secret "kv/my-secret" }}
                "trackerDB": "{{ .Data.var }}{{ end }}/trackerDB",
                                        {{ with secret "kv/my-secret" }}
                "taskDB": "{{ .Data.var }}{{ end }}/taskDB",
                                   {{ with secret "kv/my-secret" }}
                "feedDB": "{{ .Data.var }}{{ end }}/tfeedDB",
                                        {{ with secret "kv/my-secret" }}
                "userDB": "{{ .Data.var }}{{ end }}/userDB"

            }
        },

        "pod2":{
                "mongo":{
                                         {{ with secret "kv/my-secret" }}
                "trackerDB": "{{ .Data.var }}{{ end }}/trackerDB",
                                        {{ with secret "kv/my-secret" }}
                "taskDB": "{{ .Data.var }}{{ end }}/taskDB",
                                   {{ with secret "kv/my-secret" }}
                "feedDB": "{{ .Data.var }}{{ end }}/feedDB",
                                        {{ with secret "kv/my-secret" }}
                "userDB": "{{ .Data.var }}{{ end }}/userDB"
            }
         }
    }
}

