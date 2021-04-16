# SMPPEX Telemetry

[![Elixir CI](https://github.com/savonarola/smppex_telemetry/actions/workflows/elixir.yml/badge.svg)](https://github.com/savonarola/smppex_telemetry/actions/workflows/elixir.yml)

Library for tracing SMPP session ([SMPPEX.Session](https://github.com/funbox/smppex/blob/master/lib/smppex/session.ex)) events with [telemetry](https://github.com/beam-telemetry/telemetry).

`SMPPEXTelemetry`:
* implements `SMPPEX.TransportSession` protocol;
* wraps `SMPPEX.Session` module with callbacks sending `:telemetery` events.

Events are the following:
```elixir
[:smppex, :session, :init]
[:smppex, :session, :in_pdu]
[:smppex, :session, :out_pdu]
[:smppex, :session, :socket_closed]
[:smppex, :session, :socket_error]
[:smppex, :session, :terminate]
[:smppex, :session, :code_change]
```

Each event contains `session: session_pid` metadata for identifying sessions.

Usage:

```elixir
SMPPEX.ESME.start_link(
  host,
  port,
  {module, args},
  session_module: SMPPEXTelemetry.Session
)
```
or
```elixir
SMPPEX.MC.start(
  {module, args},
  transport_opts: %{
    socket_opts: [
      port: port
    ]
  },
  session_module: SMPPEXTelemetry.Session
)
```

## Installation

The package can be installed
by adding `smppex_telemetry` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:smppex_telemetry, "~> 0.1.0"}
  ]
end
```

## Credits

* [Eric Oestrich](https://github.com/oestrich) and [Vinod Kurup](https://github.com/vkurup)
for the idea and for implementation try;
* [telemetry](https://github.com/beam-telemetry/telemetry) authors.

## License

This software is licensed under [MIT License](LICENSE).


