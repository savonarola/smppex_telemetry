defmodule SMPPEXTelemetry.Session do
  @moduledoc """
    Implementation of SMPPEX.TransportSession
  """

  @module SMPPEX.Session

  @behaviour SMPPEX.TransportSession

  # SMPP.TransportSession callbacks

  def init(socket, transport, args) do
    case @module.init(socket, transport, args) do
      {:ok, state} ->
        :telemetry.execute(
          [:smppex, :session, :init],
          %{},
          %{status: :ok, session: self()}
        )

        {:ok, state}

      {:stop, reason} ->
        :telemetry.execute(
          [:smppex, :session, :init],
          %{},
          %{status: :stop, reason: reason, session: self()}
        )

        {:stop, reason}
    end
  end

  def handle_pdu({:unparsed_pdu, raw_pdu, error}, st) do
    :telemetry.execute(
      [:smppex, :session, :in_pdu],
      %{},
      %{session: self(), error: error, raw_pdu: raw_pdu}
    )

    @module.handle_pdu({:unparsed_pdu, raw_pdu, error}, st)
  end

  def handle_pdu({:pdu, pdu}, st) do
    :telemetry.execute(
      [:smppex, :session, :in_pdu],
      %{},
      %{session: self(), pdu: pdu}
    )

    @module.handle_pdu({:pdu, pdu}, st)
  end

  def handle_send_pdu_result(pdu, send_pdu_result, st) do
    :telemetry.execute(
      [:smppex, :session, :out_pdu],
      %{},
      %{session: self(), pdu: pdu, send_pdu_result: send_pdu_result}
    )

    @module.handle_send_pdu_result(pdu, send_pdu_result, st)
  end

  def handle_call(message, from, st) do
    @module.handle_call(message, from, st)
  end

  def handle_cast(message, st) do
    @module.handle_cast(message, st)
  end

  def handle_info(message, st) do
    @module.handle_info(message, st)
  end

  def handle_socket_closed(st) do
    :telemetry.execute(
      [:smppex, :session, :socket_closed],
      %{},
      %{session: self()}
    )

    @module.handle_socket_closed(st)
  end

  def handle_socket_error(error, st) do
    :telemetry.execute(
      [:smppex, :session, :socket_error],
      %{},
      %{session: self(), error: error}
    )

    @module.handle_socket_error(error, st)
  end

  def terminate(reason, st) do
    :telemetry.execute(
      [:smppex, :session, :terminate],
      %{},
      %{session: self(), reason: reason}
    )

    @module.terminate(reason, st)
  end

  def code_change(old_vsn, st, extra) do
    :telemetry.execute(
      [:smppex, :session, :code_change],
      %{},
      %{session: self(), old_vsn: old_vsn, extra: extra}
    )

    @module.code_change(old_vsn, st, extra)
  end
end
