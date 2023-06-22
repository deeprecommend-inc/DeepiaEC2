An unexpected error occurred:
Error creating new order :: too many certificates (5) already issued for this exact set of domains in the last 168 hours: deepia.tokyo, retry after 2023-06-23T13:11:29Z: see https://letsencrypt.org/docs/duplicate-certificate-limit/
Ask for help or search for solutions at https://community.letsencrypt.org. See the logfile /var/log/letsencrypt/letsencrypt.log or re-run Certbot with -v for more details.

### Reloading nginx ...
nginx: [emerg] cannot load certificate "/etc/letsencrypt/live/deepia.tokyo/fullchain.pem": BIO_new_file() failed (SSL: error:80000002:system library::No such file or directory:calling fopen(/etc/letsencrypt/live/deepia.tokyo/fullchain.pem, r) error:10000080:BIO routines::no such file)

nginx: [emerg] cannot load certificate "/etc/letsencrypt/live/deepia.tokyo/fullchain.pem": BIO_new_file() failed (SSL: error:80000002:system library::No such file or directory:calling fopen(/etc/letsencrypt/live/deepia.tokyo/fullchain.pem, r) error:10000080:BIO routines::no such file)



upstream django {
    server deepia-api:8000;
}

server {
    listen 80;
    listen [::]:80;
    server_tokens off;
    server_name deepia.tokyo;

    location / {
        return 301 https://$host$request_uri;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_tokens off;
    server_name deepia.tokyo;

    ssl_certificate /etc/letsencrypt/live/deepia.tokyo/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/deepia.tokyo/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://django;
    }
}

ChatGPT
あなたが直面しているエラーは、一週間（168時間）の間にある特定のドメインセット（この場合、deepia.tokyo）に対して多くの証明書（5つ）が既に発行されているため、新たな証明書を作成することができないというものです。これはLet's Encryptのレート制限によるもので、特定の時間内に発行できる証明書の数が制限されています。

エラーメッセージによれば、2023年6月23日の13:11:29（UTC）以降に再試行することが推奨されています。詳しくは、Let's Encryptの公式ドキュメントのレート制限に関するページをご覧ください。

そのため、指定した時間まで待つか、別のドメインを使用することでこの問題を解決できます。また、テストや開発中にはステージング環境を使用することで、このような制限を回避できます。

また、Nginxのリロード時にエラーが発生していますが、これは先述した証明書が存在しないためです。再試行時間が来るまで待ち、その後証明書を再度生成してみてください。証明書が正しく生成されれば、Nginxは正常にリロードできるはずです。