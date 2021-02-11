{% from "snmp/map.jinja" import snmp with context %}
{% from "snmp/conftrap.jinja" import conf with context -%}

include:
  - snmp.trap

snmptrap_conf:
  file.managed:
    - name: {{ snmp.configtrap }}
    - template: jinja
    - context:
      config: {{ conf.get('settings', {}) | json }}
      traps: {{ conf.get('traphandles', []) | json }}
    - source: {{ snmp.sourcetrap }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: {{ snmp.servicetrap }}
