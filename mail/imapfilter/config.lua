options.timeout = 120
options.subscribe = true


gmail_priv = IMAP {
    server = 'imap.gmail.com',
    username = 'martinuzak136@gmail.com',
    password = io.popen("pass show gmail-mbsync"):read("*line"),
    ssl = 'ssl3'
}

-- gmail_work = IMAP {
--     server = 'imap.gmail.com',
--     username = 'martin.uzak@prontohousing.com',
--     password = io.popen("pass show prontohousing/gmail-mbsync"):read("*line"),
--     ssl = 'ssl3'
-- }

mailbox_org = IMAP {
    server = 'imap.mailbox.org',
    username = 'uzak@mailbox.org',
    password = io.popen("pass show mailbox.org"):read("*line"),
    ssl = 'ssl3'
}


function ensure_folder_exists(account, folder_name)
    folders = account:list_all()
    if not string.match(table.concat(folders, "\n"), folder_name) then
        account:create_mailbox(folder_name)
    end
end


-----------------------
-- Account: mailbox
-----------------------
print('Processing martin.uzak@mailbox.org')
-- ensure_folder_exists(mailbox_org, 'ana')

-- local efimera = mailbox_org.INBOX:contain_from('anne.efimera@gmail.com')
-- local hogarmx = mailbox_org.INBOX:contain_from('anabela.elhogarmexicano@gmail.com')

-- print("efimera", #efimera)
-- print("hogarmx", #hogarmx)

-- local ana = efimera + hogarmx
-- ana:move_messages(mailbox_org['ana'])

-----------------------
-- Account: gmail_priv
-----------------------
print('Processing martinuzak136@google.com')
ensure_folder_exists(gmail_priv, 'github')

local github_emails = gmail_priv.INBOX:contain_from('notifications@github.com')
local merged_into = github_emails:match_body('Merged.*into.*')
local approved_pr = github_emails:match_body('.*approved.*this.*pull.*request')

print("github_emails", #github_emails)
print("merged_into", #merged_into)
print("approved_pr", #approved_pr)

local basically_spam = merged_into + approved_pr
basically_spam:move_messages(gmail_priv['github'])

old_emails = gmail_priv['github']:is_older(90)
old_emails:delete_messages()


-----------------------
-- Account: gmail_work
-----------------------
-- print('Processing martin.uzak@prontohousing.com')
-- ensure_folder_exists(gmail_work, 'secondary')

-- -- alarms
-- alarms = gmail_work.INBOX:contain_from('no-reply@sns.amazonaws.com')
-- alarms:contain_subject('ALARM')
-- live = alarms:contain_subject('live')
-- prod = alarms:contain_subject('prod')
-- not_alarms = alarms - (live + prod)
-- not_alarms = not_alarms:is_older(1) -- pay attention to not alarms on the first day
-- not_alarms = not_alarms + alarms:contain_subject('replicate-live-s3-to-stage-dev')
-- alarms_7d = alarms:is_older(7) - not_alarms

-- print("alarms", #alarms)
-- print("live", #live)
-- print("prod", #prod)
-- print("not_alarms", #not_alarms)
-- print("alarms_7d", #alarms_7d)

-- not_alarms:move_messages(gmail_work['secondary'])
-- alarms_7d:move_messages(gmail_work['secondary'])

-- -- fax
-- engineering = gmail_work.INBOX:contain_from('engineering@prontohousing.com')
-- mfax = engineering:match_header('X-Original-Sender: noreply@notify.mfax.io')
-- print("mfax", #mfax)
-- mfax:move_messages(gmail_work['secondary'])

-- -- twilio
-- twilio = engineering:match_header('X-Original-Sender: donotreply@twilio.com') + engineering:match_header('X-Original-From: trusthub-verify@twilio.com') + engineering:match_header('X-Original-Sender: no-reply@twilio.com')
-- print("twilio", #twilio)
-- twilio:move_messages(gmail_work['secondary'])

-- -- box
-- box = engineering:match_header('X-Original-Sender: noreply@box.com')
-- print("box", #box)
-- box:move_messages(gmail_work['secondary'])

-- -- dmarc
-- dmarc_ms = engineering:match_header('X-Original-Sender: dmarcreport@microsoft.com')
-- dmarc_google = engineering:match_header('X-Original-Sender: noreply-dmarc-support@google.com')
-- dmarc = dmarc_ms + dmarc_google

-- print("dmarc", #dmarc)
-- dmarc:move_messages(gmail_work['secondary'])

-- -- cleanup
-- old_emails = gmail_work['secondary']:is_older(90)
-- old_emails:delete_messages()
