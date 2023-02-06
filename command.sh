#!/bin/bash

# サイトの言語を設定
wp --allow-root core language install ja --activate

# タイムゾーンを設定
wp --allow-root option update timezone_string 'Asia/Tokyo'

# 日付フォーマットを設定
wp --allow-root option update date_format 'Y-m-d'

# 時刻フォーマットを設定
wp --allow-root option update time_format 'H:i'

# パーマリンクを投稿名に設定
wp --allow-root rewrite structure '/%postname%/'

# リライトルールを更新
wp --allow-root rewrite flush

# サンプルの投稿、固定ページを削除
wp --allow-root post delete 1 2 3 --force

# サンプルのコメントを削除
wp --allow-root comment delete 1 --force

# 必要なプラグインインストール
wp --allow-root plugin install wp-multibyte-patch --activate
wp --allow-root plugin install all-in-one-wp-security-and-firewall --activate
wp --allow-root plugin install advanced-custom-fields --activate
wp --allow-root plugin install ewww-image-optimizer --activate
wp --allow-root plugin install all-in-one-wp-migration --activate
wp --allow-root plugin install wordpress-seo --activate
wp --allow-root plugin install contact-form-7 --activate
wp --allow-root plugin install duplicate-post --activate
wp --allow-root plugin install admin-bar-position --activate
wp --allow-root plugin install classic-editor --activate
wp --allow-root plugin install akismet --activate
wp --allow-root plugin install broken-link-checker --activate
wp --allow-root plugin install post-types-order --activate

# Mailhog メールが文字化けしないよう WP Multibyte Patch の設定調整
# https://eastcoder.com/code/wp-multibyte-patch/
echo "<?php
\$wpmp_conf['mail_mode'] = 'UTF-8';
\$wpmp_conf['patch_wp_mail'] = false;
" >> wp-content/wpmp-config.php

# WordPress 日本語コアファイルをアップデート
wp --allow-root core update --locale=ja --force
