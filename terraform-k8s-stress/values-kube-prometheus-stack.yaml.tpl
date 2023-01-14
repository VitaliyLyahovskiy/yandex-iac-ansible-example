grafana:
  enabled: true
  ingress:
    enabled: true
    ingressClassName: nginx
    hosts:
     - promgrafana.apatsev.org.ru
    path: /

alertmanager:
  config:
    global:
      resolve_timeout: 5m
    inhibit_rules:
      - source_matchers:
          - 'severity = critical'
        target_matchers:
          - 'severity =~ warning|info'
        equal:
          - 'namespace'
          - 'alertname'
      - source_matchers:
          - 'severity = warning'
        target_matchers:
          - 'severity = info'
        equal:
          - 'namespace'
          - 'alertname'
      - source_matchers:
          - 'alertname = InfoInhibitor'
        target_matchers:
          - 'severity = info'
        equal:
          - 'namespace'
    route:
      # Группировка алертов
      group_by: ['alertname', 'cluster', 'service']
      # время ожидания перед отправкой уведомления для группы
      group_wait: 10s
      # время отправки повторного сообщения для группы
      group_interval: 10s
      # время до отправки повторного сообщения
      repeat_interval: 10s
      receiver: 'telega'
    receivers:
      - name: 'telega'
        telegram_configs:
          - bot_token: "${bot_token}"
            api_url: 'https://api.telegram.org'
            chat_id: ${chat_id}
            message:  "Alertname: {{ .GroupLabels.alertname }}\n Severity: {{ .CommonLabels.severity }}\n {{ range .Alerts }}{{ .Annotations.description }}\n{{ end }}"
            parse_mode: 'HTML'
