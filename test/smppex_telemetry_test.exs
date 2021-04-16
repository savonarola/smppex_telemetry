defmodule SMPPEXTelemetryTest do
  use ExUnit.Case

  alias Support.MC
  alias Support.ESME
  alias SMPPEX.Pdu

  require Logger

  def find_free_port do
    {:ok, socket} = :gen_tcp.listen(0, [])
    {:ok, port} = :inet.port(socket)
    :ok = :gen_tcp.close(socket)
    port
  end

  def log_event(event, _measurements, metadata, _config) do
    Logger.warn("Event: #{inspect(event)}, metadata: #{inspect(metadata)}")
  end

  test "pdu exchange" do
    :ok =
      :telemetry.attach_many(
        "log-session-events",
        [
          [:smppex, :session, :init],
          [:smppex, :session, :in_pdu],
          [:smppex, :session, :out_pdu],
          [:smppex, :session, :socket_closed],
          [:smppex, :session, :socket_error],
          [:smppex, :session, :terminate],
          [:smppex, :session, :code_change]
        ],
        &log_event/4,
        nil
      )

    port = find_free_port()
    {:ok, ref} = MC.start(port)

    {:ok, _pid} = ESME.start_link(port)

    receive do
      {bind_resp, bind} ->
        assert :bind_transceiver_resp == Pdu.command_name(bind_resp)
        assert :bind_transceiver == Pdu.command_name(bind)
    after
      1000 ->
        assert false
    end

    MC.stop(ref)
  end
end
