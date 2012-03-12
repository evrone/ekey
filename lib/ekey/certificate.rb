# Модуль Certificate отвечает за отправление запроса на сертификат (CSR) и получение готового сертификата.
#
# Комплекс взаимодействия с ekey.ru:
#    - issue -- отправляет запрос на выпуск сертификата
#       на вход: csr в формате pem
#       ответ: ruby hash в формате {"created_request_id" => <number>} или {"error" => <message>}
#    - get_certificates -- забирает с Удостоверяющего центра (УЦ, CA) готовые сертификаты
#       на вход: id сертификатов в очереди на выпуск (request_ids)
#       ответ: json в формате [{"id" => <request_id>, "certificate" => <certificate_body>},
#              если серт. еще не выпущен - {"id" => <request_id>, "error" => "certificate is not ready yet"}]

require 'rest_client'
require 'json'

module Ekey
  class Certificate
    CA_UPLOAD_PAGE_URL   = "http://cabinet.ekey.ru/api/1.0/request/put"
    CA_DOWNLOAD_PAGE_URL = "http://cabinet.ekey.ru/api/1.0/certificates/get"

    CERTIFICATE_LINE_LENGTH = 64

    # Делит длинную строку base64 на строки по 64 символа.
    # Это требование cabinet.ekey.ru к запросам на выпуск сертификата (CSR).
    def self.add_container_to_csr(cert_req)
      stripted_body = cert_req.gsub("-----BEGIN CERTIFICATE REQUEST-----", '').gsub("-----END CERTIFICATE REQUEST-----", '').gsub(/[\r\n\s]/, '')
      parts = stripted_body.scan(/.{1,#{CERTIFICATE_LINE_LENGTH}}/)
      csr_with_container = "-----BEGIN CERTIFICATE REQUEST-----\n#{parts.join("\n")}\n-----END CERTIFICATE REQUEST-----"
    end

    def self.issue(csr)
      upload_responce = RestClient.post(CA_UPLOAD_PAGE_URL,
                                        { :api_key => Ekey::Config.api_key,
                                          :pkcs10 => add_container_to_csr(csr) },
                                        :multipart => true)
      JSON(upload_responce)
    end

    def self.get_certificates(ca_request_ids)
      id_list = Array(ca_request_ids).join(', ')
      ca_responce = RestClient.post(CA_DOWNLOAD_PAGE_URL, { :api_key => Ekey::Config.api_key,
                                                            :id_list => id_list })
      JSON(ca_responce)
    end

  end
end

