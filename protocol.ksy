meta:
  id: aurium
  title: Aurium Networking Protocol
  endian: be
seq:
  - id: header
    type: message_header
types:
  message_header:
    seq:
      - id: opcode
        type: b5
        enum: enum_msgtype
      - id: extensions
        type: b11

enums:
  enum_msgtype:
    0x00: node_id_req
    0x01: node_id_resp
    