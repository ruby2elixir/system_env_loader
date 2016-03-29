# SystemEnvLoader

A little package to load files like

```bash
export SECRET_KEY_BASE=""
export DATABASE_USERNAME=""
export DATABASE_PASSWORD="pass"
export DATABASE_NAME="db_name"
export DATABASE_SERVER="db-host.example.com"
export API_SIGN_SECRET="XXX"
```
into your Elixir Environment.

Works currently just with by naively parsing the file without further evaluation (so `B=$A`) wont work.



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add system_env_loader to your list of dependencies in `mix.exs`:

        def deps do
          [{:system_env_loader, "~> 0.1.0"}]
        end


## Usage

```elixir
SystemEnvLoader.load("config/.env")
```


