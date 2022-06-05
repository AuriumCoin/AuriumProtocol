meta:
  id: aurium
  title: Aurium Networking Protocol
  endian: be
seq:
  - id: header
    type: u2be
instances:
    opcode:
        value: (header & 0x1f) >> 3
        enum: enum_msgtype
    extensions:
        value: header & 0x7FF

enums:
  enum_msgtype:
    0x00: node_id_req
    0x01: node_id_resp
    