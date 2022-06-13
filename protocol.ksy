meta:
  id: aurium
  title: Aurium Networking Protocol
  endian: be
seq:
  - id: header
    type: message_header
  - id: body
    type:
      switch-on: header.opcode
      cases:
        'enum_msgtype::node_id_exchange': msg_node_id_exchange
enums:
  enum_msgtype:
    0x00: node_id_exchange
    0x02: keepalive

types:
  message_header:
    seq:
      - id: opcode
        type: b5
        enum: enum_msgtype
      - id: extensions
        type: b11
    instances:
        cooke_flag:
            value: extensions & 1
        response_flag:
            value: extensions & 2
        connecting_flag:
            value: extensions & 4
        rep_count:
            value: (extensions >> 3) & 0x1f

  msg_node_id_exchange:
    seq:
      - id: version
        if: _root.header.connecting_flag != 0
        type: node_version_info  
      - id: cookie
        if: _root.header.cooke_flag != 0
        type: node_cookie

  node_version_info:
    seq:
      - id: version
        type: u2be
        doc: Version which Node is on
      - id: version_min
        type: u2be
        doc: The minimum version Node accepts. If minimum > version then deny connecion.

  node_cookie:
    seq:
      - id: can_bootstrap
        type: b1
      - id: reserved
        type: b7
        doc: If you can bootstrap with this node (If Light Node this is 0 / false)
      - id: cookie
        size: 32
      - id: node_id
        size: 32

  node_id_response:
    seq:
      - id: entry
        type: representative_entry
        repeat: until
        repeat-until: _index == _root.header.rep_count
      - id: signature
        size: 32
    types:
      representative_entry:
        seq:
          - id: representative
            size: 32
            doc: Account
          - id: signature
            size: 64