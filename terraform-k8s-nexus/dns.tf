resource "yandex_dns_zone" "apatsev_org_ru" {
 name   = "apatsev-org-ru"
 zone   = "apatsev.org.ru."
 public = true
}

resource "yandex_dns_recordset" "nexus_apatsev_org_ru" {
 zone_id = yandex_dns_zone.apatsev_org_ru.id
 name    = "nexus.apatsev.org.ru."
 type    = "A"
 ttl     = 200
 data    = [yandex_vpc_address.nexus_address.external_ipv4_address[0].address]
}
