#lang racket/base
;; This file is generated by "emoji-parse.rkt"
;; with the Unicode standard files
;; "emoji-sequences.text" and "emoji-zwj-sequences.text"
;; provided as input
(require parser-tools/lex (prefix-in : parser-tools/lex-sre))
(provide one-char-emoji emoji)
(define-lex-abbrevs
 (one-char-emoji
  (:or
   "🃏"
   "🀄"
   "🧸"
   "🧹"
   "🧺"
   "🧻"
   "🧼"
   "🧽"
   "🧾"
   "🧿"
   "🧰"
   "🧱"
   "🧲"
   "🧳"
   "🧴"
   "🧵"
   "🧶"
   "🧷"
   "🧨"
   "🧩"
   "🧪"
   "🧫"
   "🧬"
   "🧭"
   "🧮"
   "🧯"
   "🧠"
   "🧡"
   "🧢"
   "🧣"
   "🧤"
   "🧥"
   "🧦"
   "🧧"
   "🧘"
   "🧙"
   "🧚"
   "🧛"
   "🧜"
   "🧝"
   "🧞"
   "🧟"
   "🧐"
   "🧑"
   "🧒"
   "🧓"
   "🧔"
   "🧕"
   "🧖"
   "🧗"
   "🧈"
   "🧉"
   "🧊"
   "🧋"
   "🧌"
   "🧍"
   "🧎"
   "🧏"
   "🧀"
   "🧁"
   "🧂"
   "🧃"
   "🧄"
   "🧅"
   "🧆"
   "🧇"
   "🦸"
   "🦹"
   "🦺"
   "🦻"
   "🦼"
   "🦽"
   "🦾"
   "🦿"
   "🦰"
   "🦱"
   "🦲"
   "🦳"
   "🦴"
   "🦵"
   "🦶"
   "🦷"
   "🦨"
   "🦩"
   "🦪"
   "🦫"
   "🦬"
   "🦭"
   "🦮"
   "🦯"
   "🦠"
   "🦡"
   "🦢"
   "🦣"
   "🦤"
   "🦥"
   "🦦"
   "🦧"
   "🦘"
   "🆑"
   "🦙"
   "🆒"
   "🦚"
   "🆓"
   "🦛"
   "🆔"
   "🦜"
   "🆕"
   "🦝"
   "🆖"
   "🦞"
   "🆗"
   "🦟"
   "🆘"
   "🦐"
   "🆙"
   "🦑"
   "🆚"
   "🦒"
   "🦓"
   "🦔"
   "🦕"
   "🦖"
   "🦗"
   "🦈"
   "🦉"
   "🦊"
   "🦋"
   "🦌"
   "🦍"
   "🦎"
   "🦏"
   "🦀"
   "🦁"
   "🦂"
   "🦃"
   "🦄"
   "🦅"
   "🆎"
   "🦆"
   "🦇"
   "🥸"
   "🥹"
   "🥺"
   "🥻"
   "🥼"
   "🥽"
   "🥾"
   "🥿"
   "🥰"
   "🥱"
   "🥲"
   "🥳"
   "🥴"
   "🥵"
   "🥶"
   "🥷"
   "🥨"
   "🥩"
   "🥪"
   "🥫"
   "🥬"
   "🥭"
   "🥮"
   "🥯"
   "🥠"
   "🥡"
   "🥢"
   "🥣"
   "🥤"
   "🥥"
   "🥦"
   "🥧"
   "🥘"
   "🥙"
   "🥚"
   "🥛"
   "🥜"
   "🥝"
   "🥞"
   "🥟"
   "🥐"
   "🥑"
   "🥒"
   "🥓"
   "🥔"
   "🥕"
   "🥖"
   "🥗"
   "🥈"
   "🥉"
   "🥊"
   "🥋"
   "🥌"
   "🥍"
   "🥎"
   "🥏"
   "🥀"
   "🥁"
   "🥂"
   "🥃"
   "🥄"
   "🥅"
   "🥇"
   "🤸"
   "🤹"
   "🤺"
   "🤼"
   "🤽"
   "🤾"
   "🤿"
   "🤰"
   "🤱"
   "🤲"
   "🤳"
   "🤴"
   "🤵"
   "🤶"
   "🤷"
   "🤨"
   "🤩"
   "🤪"
   "🤫"
   "🤬"
   "🤭"
   "🤮"
   "🤯"
   "🤠"
   "🤡"
   "🤢"
   "🤣"
   "🤤"
   "🤥"
   "🤦"
   "🤧"
   "🤘"
   "🤙"
   "🤚"
   "🤛"
   "🤜"
   "🤝"
   "🤞"
   "🤟"
   "🤐"
   "🤑"
   "🤒"
   "🤓"
   "🤔"
   "🤕"
   "🤖"
   "🤗"
   "🤌"
   "🤍"
   "🤎"
   "🤏"
   "🫳"
   "🫲"
   "🫱"
   "🫰"
   "🫶"
   "🫵"
   "🫴"
   "🫣"
   "🫢"
   "🫡"
   "🫠"
   "🫧"
   "🫦"
   "🫥"
   "🫤"
   "🫙"
   "🫘"
   "🫓"
   "🫒"
   "🫑"
   "🫐"
   "🫗"
   "🫖"
   "🫕"
   "🫔"
   "🫃"
   "🫂"
   "🫁"
   "🫀"
   "🫅"
   "🫄"
   "🪺"
   "🪹"
   "🪸"
   "🪳"
   "🪲"
   "🪱"
   "🪰"
   "🪷"
   "🪶"
   "🪵"
   "🪴"
   "🪫"
   "🪪"
   "🪩"
   "🪨"
   "🪬"
   "🪣"
   "🪢"
   "🪡"
   "🪠"
   "🪧"
   "🪦"
   "🪥"
   "🪤"
   "🪛"
   "🪚"
   "🪙"
   "🪘"
   "🪟"
   "🪞"
   "🪝"
   "🪜"
   "🪓"
   "🪒"
   "🪑"
   "🪐"
   "🪗"
   "🪖"
   "🪕"
   "🪔"
   "🪃"
   "🪂"
   "🪁"
   "🪀"
   "🪆"
   "🪅"
   "🪄"
   "🩻"
   "🩺"
   "🩹"
   "🩸"
   "🩼"
   "🩳"
   "🩲"
   "🩱"
   "🩰"
   "🩴"
   "🉑"
   "🉐"
   "🈳"
   "🈲"
   "🈶"
   "🈵"
   "🈴"
   "🈺"
   "🈹"
   "🈸"
   "🈯"
   "🈚"
   "🈁"
   "🏰"
   "🏴"
   "🏺"
   "🏻"
   "🏸"
   "🏹"
   "🏾"
   "🏿"
   "🏼"
   "🏽"
   "🏢"
   "🏣"
   "🏠"
   "🏡"
   "🏦"
   "🏧"
   "🏤"
   "🏥"
   "🏪"
   "🏫"
   "🏨"
   "🏩"
   "🏮"
   "🏯"
   "🏬"
   "🏭"
   "🏒"
   "🏓"
   "🏐"
   "🏑"
   "⬛"
   "🏂"
   "🏃"
   "🏀"
   "🏁"
   "🏆"
   "🏇"
   "🏄"
   "🏅"
   "⬜"
   "🏊"
   "⌛"
   "⌚"
   "🏈"
   "🏉"
   "🏏"
   "🎲"
   "🎳"
   "🎰"
   "🎱"
   "🎶"
   "🎷"
   "🎴"
   "🎵"
   "🎺"
   "🎻"
   "🎸"
   "🎹"
   "🎾"
   "🎿"
   "🎼"
   "🎽"
   "🎢"
   "🎣"
   "🎠"
   "🎡"
   "🎦"
   "🎧"
   "🎤"
   "🎥"
   "🎪"
   "🎫"
   "🎨"
   "🎩"
   "🎮"
   "🎯"
   "🎬"
   "🎭"
   "🎒"
   "🎓"
   "🎐"
   "🎑"
   "🎂"
   "🎃"
   "🎀"
   "🎁"
   "🎆"
   "🎇"
   "🎄"
   "🎅"
   "🎊"
   "🎋"
   "🎈"
   "⭐"
   "🎉"
   "🎎"
   "🎏"
   "⭕"
   "🎌"
   "🎍"
   "🍲"
   "🍳"
   "🍰"
   "🍱"
   "🍶"
   "🍷"
   "🍴"
   "🍵"
   "🍺"
   "🍻"
   "🍸"
   "🍹"
   "🍾"
   "🍿"
   "🍼"
   "🍢"
   "🍣"
   "🍠"
   "🍡"
   "🍦"
   "🍧"
   "🍤"
   "🍥"
   "🍪"
   "🍫"
   "🍨"
   "🍩"
   "🍮"
   "🍯"
   "🍬"
   "🍭"
   "🍒"
   "🍓"
   "🍐"
   "🍑"
   "🍖"
   "🍗"
   "🍔"
   "🍕"
   "🍚"
   "🍛"
   "🍘"
   "🍙"
   "🍞"
   "🍟"
   "🍜"
   "🍝"
   "🍂"
   "🍃"
   "🍀"
   "🍁"
   "🍆"
   "🍇"
   "🍄"
   "🍅"
   "🍊"
   "🍋"
   "🍈"
   "🍉"
   "🍎"
   "🍏"
   "🍌"
   "🍍"
   "🌲"
   "🌳"
   "🌰"
   "🌱"
   "🌷"
   "🌴"
   "🌵"
   "⏫"
   "🌺"
   "⏪"
   "🌻"
   "⏩"
   "🌸"
   "🌹"
   "🌾"
   "🌿"
   "🌼"
   "⏬"
   "🌽"
   "⏳"
   "🌠"
   "⏰"
   "🌮"
   "🌯"
   "🌭"
   "🌒"
   "🌓"
   "🌐"
   "🌑"
   "🌖"
   "🌗"
   "🌔"
   "🌕"
   "🌚"
   "🌛"
   "🌘"
   "🌙"
   "🌞"
   "🌟"
   "🌜"
   "🌝"
   "🌂"
   "🌃"
   "🌀"
   "🌁"
   "🌆"
   "🌇"
   "🌄"
   "🌅"
   "🌊"
   "🌋"
   "🌈"
   "🌉"
   "🌎"
   "🌏"
   "🌌"
   "🌍"
   "📵"
   "📴"
   "📷"
   "📶"
   "📱"
   "📰"
   "📳"
   "📲"
   "📼"
   "📿"
   "📹"
   "📸"
   "📻"
   "📺"
   "📥"
   "📤"
   "📧"
   "📦"
   "📡"
   "📠"
   "📣"
   "📢"
   "📭"
   "📬"
   "📯"
   "📮"
   "📩"
   "📨"
   "📫"
   "📪"
   "📕"
   "📔"
   "📗"
   "📖"
   "📑"
   "📐"
   "📓"
   "📒"
   "📝"
   "📜"
   "📟"
   "📞"
   "📙"
   "📘"
   "📛"
   "📚"
   "📅"
   "📄"
   "📇"
   "📆"
   "📁"
   "📀"
   "📃"
   "📂"
   "📍"
   "📌"
   "📏"
   "📎"
   "📉"
   "📈"
   "📋"
   "📊"
   "💵"
   "💴"
   "💷"
   "💶"
   "💱"
   "💰"
   "💳"
   "💲"
   "💽"
   "💼"
   "💿"
   "💾"
   "💹"
   "💸"
   "💻"
   "💺"
   "💥"
   "💤"
   "💧"
   "💦"
   "💡"
   "💠"
   "💣"
   "💢"
   "💭"
   "💬"
   "💯"
   "💮"
   "💩"
   "💨"
   "💫"
   "💪"
   "💕"
   "💔"
   "💗"
   "💖"
   "💑"
   "💐"
   "💓"
   "💒"
   "💝"
   "💜"
   "💟"
   "💞"
   "💙"
   "💘"
   "💛"
   "💚"
   "💅"
   "💄"
   "💇"
   "💆"
   "💁"
   "💀"
   "💃"
   "💂"
   "💍"
   "💌"
   "💏"
   "💎"
   "💉"
   "💈"
   "💋"
   "💊"
   "👵"
   "👴"
   "👷"
   "👶"
   "👱"
   "👰"
   "👳"
   "👲"
   "👽"
   "👼"
   "👿"
   "👾"
   "👹"
   "👸"
   "👻"
   "👺"
   "👥"
   "👤"
   "👧"
   "👦"
   "👡"
   "👠"
   "👣"
   "👢"
   "👭"
   "👬"
   "👯"
   "👮"
   "👩"
   "👨"
   "👫"
   "👪"
   "👕"
   "👔"
   "👗"
   "👖"
   "👑"
   "👐"
   "👓"
   "👒"
   "👝"
   "👜"
   "👟"
   "👞"
   "👙"
   "👘"
   "👛"
   "👚"
   "👅"
   "👄"
   "👇"
   "👆"
   "👀"
   "👃"
   "👂"
   "👍"
   "👌"
   "👏"
   "👎"
   "👉"
   "👈"
   "👋"
   "👊"
   "🐵"
   "🐴"
   "🐷"
   "🐶"
   "🐱"
   "🐰"
   "🐳"
   "🐲"
   "🐽"
   "🐼"
   "🐾"
   "🐹"
   "🐸"
   "🐻"
   "🐺"
   "🐥"
   "🐤"
   "🐧"
   "🐦"
   "🐡"
   "🐠"
   "🐣"
   "🐢"
   "🐭"
   "🐬"
   "🐯"
   "🐮"
   "🐩"
   "🐨"
   "🐫"
   "🐪"
   "🐕"
   "🐔"
   "🐗"
   "🐖"
   "🐑"
   "🐐"
   "🐓"
   "🐒"
   "🐝"
   "🐜"
   "🐟"
   "🐞"
   "🐙"
   "🐘"
   "🐛"
   "🐚"
   "🐅"
   "🐄"
   "🐇"
   "🐆"
   "🐁"
   "🐀"
   "🐃"
   "🐂"
   "🐍"
   "🐌"
   "🐏"
   "🐎"
   "🐉"
   "🐈"
   "🐋"
   "🐊"
   "🗼"
   "🗽"
   "🗾"
   "🗿"
   "🗻"
   "🖤"
   "🖕"
   "🖖"
   "🕺"
   "🕤"
   "🕥"
   "🕦"
   "🕧"
   "🕠"
   "🕡"
   "🕢"
   "🕣"
   "🕔"
   "🕕"
   "🕖"
   "🕗"
   "🕐"
   "🕑"
   "🕒"
   "🕓"
   "🕜"
   "🕝"
   "🕞"
   "🕟"
   "🕘"
   "🕙"
   "🕚"
   "🕛"
   "🕌"
   "🕍"
   "🕎"
   "🕋"
   "🔴"
   "🔵"
   "🔶"
   "🔷"
   "🔰"
   "🔱"
   "🔲"
   "🔳"
   "🔼"
   "🔽"
   "🔸"
   "🔹"
   "🔺"
   "🔻"
   "🔤"
   "🔥"
   "🔦"
   "🔧"
   "🔠"
   "🔡"
   "🔢"
   "🔣"
   "◽"
   "🔬"
   "🔭"
   "🔮"
   "◾"
   "🔯"
   "🔨"
   "🔩"
   "🔪"
   "🔫"
   "🔔"
   "🔕"
   "🔖"
   "🔗"
   "🔐"
   "🔑"
   "🔒"
   "🔓"
   "🔜"
   "🔝"
   "🔞"
   "🔟"
   "🔘"
   "🔙"
   "🔚"
   "🔛"
   "🔄"
   "🔅"
   "🔆"
   "🔇"
   "🔀"
   "🔁"
   "🔂"
   "🔃"
   "🔌"
   "🔍"
   "🔎"
   "🔏"
   "🔈"
   "🔉"
   "🔊"
   "🔋"
   "🛷"
   "🛶"
   "🛵"
   "🛴"
   "🛼"
   "🛻"
   "🛺"
   "🛹"
   "🛸"
   "🛬"
   "🛫"
   "🛗"
   "🛖"
   "🛕"
   "🛒"
   "🛑"
   "🛐"
   "🛟"
   "🛞"
   "🛝"
   "☔"
   "🛅"
   "☕"
   "🛄"
   "🛃"
   "🛂"
   "🛁"
   "🛀"
   "🛌"
   "🚷"
   "🚶"
   "🚵"
   "🚴"
   "🚳"
   "🚲"
   "🚱"
   "🚰"
   "🚿"
   "🚾"
   "🚽"
   "🚼"
   "🚻"
   "🚺"
   "🚹"
   "🚸"
   "🚧"
   "🚦"
   "🚥"
   "🚤"
   "🚣"
   "🚢"
   "🚡"
   "🚠"
   "🚯"
   "♿"
   "🚮"
   "🚭"
   "🚬"
   "🚫"
   "🚪"
   "🚩"
   "🚨"
   "🚗"
   "🚖"
   "🚕"
   "🚔"
   "🚓"
   "🚒"
   "🚑"
   "🚐"
   "♎"
   "🚟"
   "♏"
   "🚞"
   "♌"
   "🚝"
   "♍"
   "🚜"
   "♊"
   "🚛"
   "♋"
   "🚚"
   "♈"
   "🚙"
   "♉"
   "🚘"
   "🚇"
   "🚆"
   "🚅"
   "🚄"
   "♒"
   "🚃"
   "♓"
   "🚂"
   "♐"
   "🚁"
   "♑"
   "🚀"
   "🚏"
   "🚎"
   "🚍"
   "🚌"
   "🚋"
   "🚊"
   "🚉"
   "🚈"
   "⚡"
   "⚪"
   "⚫"
   "⚾"
   "⚽"
   "🙇"
   "🙆"
   "🙅"
   "🙄"
   "🙃"
   "⚓"
   "🙂"
   "🙁"
   "🙀"
   "🙏"
   "🙎"
   "🙍"
   "🙌"
   "🙋"
   "🙊"
   "🙉"
   "🙈"
   "😷"
   "😶"
   "😵"
   "😴"
   "😳"
   "😲"
   "😱"
   "😰"
   "😿"
   "😾"
   "😽"
   "😼"
   "⛪"
   "😻"
   "😺"
   "😹"
   "😸"
   "😧"
   "😦"
   "😥"
   "⛵"
   "😤"
   "⛲"
   "😣"
   "⛳"
   "😢"
   "😡"
   "😠"
   "😯"
   "😮"
   "😭"
   "⛽"
   "😬"
   "⛺"
   "😫"
   "😪"
   "😩"
   "😨"
   "😗"
   "😖"
   "⛄"
   "😕"
   "⛅"
   "😔"
   "😓"
   "😒"
   "😑"
   "😐"
   "⛎"
   "😟"
   "😞"
   "😝"
   "😜"
   "😛"
   "😚"
   "😙"
   "😘"
   "😇"
   "😆"
   "⛔"
   "😅"
   "😄"
   "😃"
   "😂"
   "😁"
   "😀"
   "😏"
   "😎"
   "😍"
   "😌"
   "😋"
   "😊"
   "😉"
   "😈"
   "🟰"
   "✨"
   "🟦"
   "🟧"
   "🟤"
   "🟥"
   "🟢"
   "🟣"
   "🟠"
   "🟡"
   "🟪"
   "🟫"
   "🟨"
   "🟩"
   "✅"
   "✋"
   "✊"
   "❎"
   "❌"
   "❗"
   "❕"
   "❔"
   "❓"
   "➰"
   "➿"
   "➗"
   "➖"
   "➕"))
 (emoji
  (:or
   "⌚"
   "⌛"
   "⏩"
   "⏪"
   "⏫"
   "⏬"
   "⏰"
   "⏳"
   "◽"
   "◾"
   "☔"
   "☕"
   "♈"
   "♉"
   "♊"
   "♋"
   "♌"
   "♍"
   "♎"
   "♏"
   "♐"
   "♑"
   "♒"
   "♓"
   "♿"
   "⚓"
   "⚡"
   "⚪"
   "⚫"
   "⚽"
   "⚾"
   "⛄"
   "⛅"
   "⛎"
   "⛔"
   "⛪"
   "⛲"
   "⛳"
   "⛵"
   "⛺"
   "⛽"
   "✅"
   "✨"
   "❌"
   "❎"
   "❓"
   "❔"
   "❕"
   "❗"
   "➕"
   "➖"
   "➗"
   "➰"
   "➿"
   "⬛"
   "⬜"
   "⭐"
   "⭕"
   "🀄"
   "🃏"
   "🆎"
   "🆑"
   "🆒"
   "🆓"
   "🆔"
   "🆕"
   "🆖"
   "🆗"
   "🆘"
   "🆙"
   "🆚"
   "🈁"
   "🈚"
   "🈯"
   "🈲"
   "🈳"
   "🈴"
   "🈵"
   "🈶"
   "🈸"
   "🈹"
   "🈺"
   "🉐"
   "🉑"
   "🌀"
   "🌁"
   "🌂"
   "🌃"
   "🌄"
   "🌅"
   "🌆"
   "🌇"
   "🌈"
   "🌉"
   "🌊"
   "🌋"
   "🌌"
   "🌍"
   "🌎"
   "🌏"
   "🌐"
   "🌑"
   "🌒"
   "🌓"
   "🌔"
   "🌕"
   "🌖"
   "🌗"
   "🌘"
   "🌙"
   "🌚"
   "🌛"
   "🌜"
   "🌝"
   "🌞"
   "🌟"
   "🌠"
   "🌭"
   "🌮"
   "🌯"
   "🌰"
   "🌱"
   "🌲"
   "🌳"
   "🌴"
   "🌵"
   "🌷"
   "🌸"
   "🌹"
   "🌺"
   "🌻"
   "🌼"
   "🌽"
   "🌾"
   "🌿"
   "🍀"
   "🍁"
   "🍂"
   "🍃"
   "🍄"
   "🍅"
   "🍆"
   "🍇"
   "🍈"
   "🍉"
   "🍊"
   "🍋"
   "🍌"
   "🍍"
   "🍎"
   "🍏"
   "🍐"
   "🍑"
   "🍒"
   "🍓"
   "🍔"
   "🍕"
   "🍖"
   "🍗"
   "🍘"
   "🍙"
   "🍚"
   "🍛"
   "🍜"
   "🍝"
   "🍞"
   "🍟"
   "🍠"
   "🍡"
   "🍢"
   "🍣"
   "🍤"
   "🍥"
   "🍦"
   "🍧"
   "🍨"
   "🍩"
   "🍪"
   "🍫"
   "🍬"
   "🍭"
   "🍮"
   "🍯"
   "🍰"
   "🍱"
   "🍲"
   "🍳"
   "🍴"
   "🍵"
   "🍶"
   "🍷"
   "🍸"
   "🍹"
   "🍺"
   "🍻"
   "🍼"
   "🍾"
   "🍿"
   "🎀"
   "🎁"
   "🎂"
   "🎃"
   "🎄"
   "🎆"
   "🎇"
   "🎈"
   "🎉"
   "🎊"
   "🎋"
   "🎌"
   "🎍"
   "🎎"
   "🎏"
   "🎐"
   "🎑"
   "🎒"
   "🎓"
   "🎠"
   "🎡"
   "🎢"
   "🎣"
   "🎤"
   "🎥"
   "🎦"
   "🎧"
   "🎨"
   "🎩"
   "🎪"
   "🎫"
   "🎬"
   "🎭"
   "🎮"
   "🎯"
   "🎰"
   "🎱"
   "🎲"
   "🎳"
   "🎴"
   "🎵"
   "🎶"
   "🎷"
   "🎸"
   "🎹"
   "🎺"
   "🎻"
   "🎼"
   "🎽"
   "🎾"
   "🎿"
   "🏀"
   "🏁"
   "🏅"
   "🏆"
   "🏈"
   "🏉"
   "🏏"
   "🏐"
   "🏑"
   "🏒"
   "🏓"
   "🏠"
   "🏡"
   "🏢"
   "🏣"
   "🏤"
   "🏥"
   "🏦"
   "🏧"
   "🏨"
   "🏩"
   "🏪"
   "🏫"
   "🏬"
   "🏭"
   "🏮"
   "🏯"
   "🏰"
   "🏸"
   "🏹"
   "🏺"
   "🏻"
   "🏼"
   "🏽"
   "🏾"
   "🏿"
   "🐀"
   "🐁"
   "🐂"
   "🐃"
   "🐄"
   "🐅"
   "🐆"
   "🐇"
   "🐉"
   "🐊"
   "🐋"
   "🐌"
   "🐍"
   "🐎"
   "🐏"
   "🐐"
   "🐑"
   "🐒"
   "🐓"
   "🐔"
   "🐖"
   "🐗"
   "🐘"
   "🐙"
   "🐚"
   "🐛"
   "🐜"
   "🐝"
   "🐞"
   "🐟"
   "🐠"
   "🐡"
   "🐢"
   "🐣"
   "🐤"
   "🐥"
   "🐧"
   "🐨"
   "🐩"
   "🐪"
   "🐫"
   "🐬"
   "🐭"
   "🐮"
   "🐯"
   "🐰"
   "🐱"
   "🐲"
   "🐳"
   "🐴"
   "🐵"
   "🐶"
   "🐷"
   "🐸"
   "🐹"
   "🐺"
   "🐼"
   "🐽"
   "🐾"
   "👀"
   "👄"
   "👅"
   "👑"
   "👒"
   "👓"
   "👔"
   "👕"
   "👖"
   "👗"
   "👘"
   "👙"
   "👚"
   "👛"
   "👜"
   "👝"
   "👞"
   "👟"
   "👠"
   "👡"
   "👢"
   "👣"
   "👤"
   "👥"
   "👪"
   "👹"
   "👺"
   "👻"
   "👽"
   "👾"
   "👿"
   "💀"
   "💄"
   "💈"
   "💉"
   "💊"
   "💋"
   "💌"
   "💍"
   "💎"
   "💐"
   "💒"
   "💓"
   "💔"
   "💕"
   "💖"
   "💗"
   "💘"
   "💙"
   "💚"
   "💛"
   "💜"
   "💝"
   "💞"
   "💟"
   "💠"
   "💡"
   "💢"
   "💣"
   "💤"
   "💥"
   "💦"
   "💧"
   "💨"
   "💩"
   "💫"
   "💬"
   "💭"
   "💮"
   "💯"
   "💰"
   "💱"
   "💲"
   "💳"
   "💴"
   "💵"
   "💶"
   "💷"
   "💸"
   "💹"
   "💺"
   "💻"
   "💼"
   "💽"
   "💾"
   "💿"
   "📀"
   "📁"
   "📂"
   "📃"
   "📄"
   "📅"
   "📆"
   "📇"
   "📈"
   "📉"
   "📊"
   "📋"
   "📌"
   "📍"
   "📎"
   "📏"
   "📐"
   "📑"
   "📒"
   "📓"
   "📔"
   "📕"
   "📖"
   "📗"
   "📘"
   "📙"
   "📚"
   "📛"
   "📜"
   "📝"
   "📞"
   "📟"
   "📠"
   "📡"
   "📢"
   "📣"
   "📤"
   "📥"
   "📦"
   "📧"
   "📨"
   "📩"
   "📪"
   "📫"
   "📬"
   "📭"
   "📮"
   "📯"
   "📰"
   "📱"
   "📲"
   "📳"
   "📴"
   "📵"
   "📶"
   "📷"
   "📸"
   "📹"
   "📺"
   "📻"
   "📼"
   "📿"
   "🔀"
   "🔁"
   "🔂"
   "🔃"
   "🔄"
   "🔅"
   "🔆"
   "🔇"
   "🔈"
   "🔉"
   "🔊"
   "🔋"
   "🔌"
   "🔍"
   "🔎"
   "🔏"
   "🔐"
   "🔑"
   "🔒"
   "🔓"
   "🔔"
   "🔕"
   "🔖"
   "🔗"
   "🔘"
   "🔙"
   "🔚"
   "🔛"
   "🔜"
   "🔝"
   "🔞"
   "🔟"
   "🔠"
   "🔡"
   "🔢"
   "🔣"
   "🔤"
   "🔥"
   "🔦"
   "🔧"
   "🔨"
   "🔩"
   "🔪"
   "🔫"
   "🔬"
   "🔭"
   "🔮"
   "🔯"
   "🔰"
   "🔱"
   "🔲"
   "🔳"
   "🔴"
   "🔵"
   "🔶"
   "🔷"
   "🔸"
   "🔹"
   "🔺"
   "🔻"
   "🔼"
   "🔽"
   "🕋"
   "🕌"
   "🕍"
   "🕎"
   "🕐"
   "🕑"
   "🕒"
   "🕓"
   "🕔"
   "🕕"
   "🕖"
   "🕗"
   "🕘"
   "🕙"
   "🕚"
   "🕛"
   "🕜"
   "🕝"
   "🕞"
   "🕟"
   "🕠"
   "🕡"
   "🕢"
   "🕣"
   "🕤"
   "🕥"
   "🕦"
   "🕧"
   "🖤"
   "🗻"
   "🗼"
   "🗽"
   "🗾"
   "🗿"
   "😀"
   "😁"
   "😂"
   "😃"
   "😄"
   "😅"
   "😆"
   "😇"
   "😈"
   "😉"
   "😊"
   "😋"
   "😌"
   "😍"
   "😎"
   "😏"
   "😐"
   "😑"
   "😒"
   "😓"
   "😔"
   "😕"
   "😖"
   "😗"
   "😘"
   "😙"
   "😚"
   "😛"
   "😜"
   "😝"
   "😞"
   "😟"
   "😠"
   "😡"
   "😢"
   "😣"
   "😤"
   "😥"
   "😦"
   "😧"
   "😨"
   "😩"
   "😪"
   "😫"
   "😬"
   "😭"
   "😯"
   "😰"
   "😱"
   "😲"
   "😳"
   "😴"
   "😷"
   "😸"
   "😹"
   "😺"
   "😻"
   "😼"
   "😽"
   "😾"
   "😿"
   "🙀"
   "🙁"
   "🙂"
   "🙃"
   "🙄"
   "🙈"
   "🙉"
   "🙊"
   "🚀"
   "🚁"
   "🚂"
   "🚃"
   "🚄"
   "🚅"
   "🚆"
   "🚇"
   "🚈"
   "🚉"
   "🚊"
   "🚋"
   "🚌"
   "🚍"
   "🚎"
   "🚏"
   "🚐"
   "🚑"
   "🚒"
   "🚓"
   "🚔"
   "🚕"
   "🚖"
   "🚗"
   "🚘"
   "🚙"
   "🚚"
   "🚛"
   "🚜"
   "🚝"
   "🚞"
   "🚟"
   "🚠"
   "🚡"
   "🚢"
   "🚤"
   "🚥"
   "🚦"
   "🚧"
   "🚨"
   "🚩"
   "🚪"
   "🚫"
   "🚬"
   "🚭"
   "🚮"
   "🚯"
   "🚰"
   "🚱"
   "🚲"
   "🚳"
   "🚷"
   "🚸"
   "🚹"
   "🚺"
   "🚻"
   "🚼"
   "🚽"
   "🚾"
   "🚿"
   "🛁"
   "🛂"
   "🛃"
   "🛄"
   "🛅"
   "🛐"
   "🛑"
   "🛒"
   "🛕"
   "🛖"
   "🛗"
   "🛝"
   "🛞"
   "🛟"
   "🛫"
   "🛬"
   "🛴"
   "🛵"
   "🛶"
   "🛷"
   "🛸"
   "🛹"
   "🛺"
   "🛻"
   "🛼"
   "🟠"
   "🟡"
   "🟢"
   "🟣"
   "🟤"
   "🟥"
   "🟦"
   "🟧"
   "🟨"
   "🟩"
   "🟪"
   "🟫"
   "🟰"
   "🤍"
   "🤎"
   "🤐"
   "🤑"
   "🤒"
   "🤓"
   "🤔"
   "🤕"
   "🤖"
   "🤗"
   "🤠"
   "🤡"
   "🤢"
   "🤣"
   "🤤"
   "🤥"
   "🤧"
   "🤨"
   "🤩"
   "🤪"
   "🤫"
   "🤬"
   "🤭"
   "🤮"
   "🤯"
   "🤺"
   "🤿"
   "🥀"
   "🥁"
   "🥂"
   "🥃"
   "🥄"
   "🥅"
   "🥇"
   "🥈"
   "🥉"
   "🥊"
   "🥋"
   "🥌"
   "🥍"
   "🥎"
   "🥏"
   "🥐"
   "🥑"
   "🥒"
   "🥓"
   "🥔"
   "🥕"
   "🥖"
   "🥗"
   "🥘"
   "🥙"
   "🥚"
   "🥛"
   "🥜"
   "🥝"
   "🥞"
   "🥟"
   "🥠"
   "🥡"
   "🥢"
   "🥣"
   "🥤"
   "🥥"
   "🥦"
   "🥧"
   "🥨"
   "🥩"
   "🥪"
   "🥫"
   "🥬"
   "🥭"
   "🥮"
   "🥯"
   "🥰"
   "🥱"
   "🥲"
   "🥳"
   "🥴"
   "🥵"
   "🥶"
   "🥸"
   "🥹"
   "🥺"
   "🥻"
   "🥼"
   "🥽"
   "🥾"
   "🥿"
   "🦀"
   "🦁"
   "🦂"
   "🦃"
   "🦄"
   "🦅"
   "🦆"
   "🦇"
   "🦈"
   "🦉"
   "🦊"
   "🦋"
   "🦌"
   "🦍"
   "🦎"
   "🦏"
   "🦐"
   "🦑"
   "🦒"
   "🦓"
   "🦔"
   "🦕"
   "🦖"
   "🦗"
   "🦘"
   "🦙"
   "🦚"
   "🦛"
   "🦜"
   "🦝"
   "🦞"
   "🦟"
   "🦠"
   "🦡"
   "🦢"
   "🦣"
   "🦤"
   "🦥"
   "🦦"
   "🦧"
   "🦨"
   "🦩"
   "🦪"
   "🦫"
   "🦬"
   "🦭"
   "🦮"
   "🦯"
   "🦰"
   "🦱"
   "🦲"
   "🦳"
   "🦴"
   "🦷"
   "🦺"
   "🦼"
   "🦽"
   "🦾"
   "🦿"
   "🧀"
   "🧁"
   "🧂"
   "🧃"
   "🧄"
   "🧅"
   "🧆"
   "🧇"
   "🧈"
   "🧉"
   "🧊"
   "🧋"
   "🧌"
   "🧐"
   "🧠"
   "🧡"
   "🧢"
   "🧣"
   "🧤"
   "🧥"
   "🧦"
   "🧧"
   "🧨"
   "🧩"
   "🧪"
   "🧫"
   "🧬"
   "🧭"
   "🧮"
   "🧯"
   "🧰"
   "🧱"
   "🧲"
   "🧳"
   "🧴"
   "🧵"
   "🧶"
   "🧷"
   "🧸"
   "🧹"
   "🧺"
   "🧻"
   "🧼"
   "🧽"
   "🧾"
   "🧿"
   "🩰"
   "🩱"
   "🩲"
   "🩳"
   "🩴"
   "🩸"
   "🩹"
   "🩺"
   "🩻"
   "🩼"
   "🪀"
   "🪁"
   "🪂"
   "🪃"
   "🪄"
   "🪅"
   "🪆"
   "🪐"
   "🪑"
   "🪒"
   "🪓"
   "🪔"
   "🪕"
   "🪖"
   "🪗"
   "🪘"
   "🪙"
   "🪚"
   "🪛"
   "🪜"
   "🪝"
   "🪞"
   "🪟"
   "🪠"
   "🪡"
   "🪢"
   "🪣"
   "🪤"
   "🪥"
   "🪦"
   "🪧"
   "🪨"
   "🪩"
   "🪪"
   "🪫"
   "🪬"
   "🪰"
   "🪱"
   "🪲"
   "🪳"
   "🪴"
   "🪵"
   "🪶"
   "🪷"
   "🪸"
   "🪹"
   "🪺"
   "🫀"
   "🫁"
   "🫂"
   "🫐"
   "🫑"
   "🫒"
   "🫓"
   "🫔"
   "🫕"
   "🫖"
   "🫗"
   "🫘"
   "🫙"
   "🫠"
   "🫡"
   "🫢"
   "🫣"
   "🫤"
   "🫥"
   "🫦"
   "🫧"
   (:: (:or "#" "*" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9") (:: "️" "⃣"))
   (::
    (:or
     "©"
     "®"
     "‼"
     "⁉"
     "™"
     "ℹ"
     "↔"
     "↕"
     "↖"
     "↗"
     "↘"
     "↙"
     "↩"
     "↪"
     "⌨"
     "⏏"
     "⏭"
     "⏮"
     "⏯"
     "⏱"
     "⏲"
     "⏸"
     "⏹"
     "⏺"
     "Ⓜ"
     "▪"
     "▫"
     "▶"
     "◀"
     "◻"
     "◼"
     "☀"
     "☁"
     "☂"
     "☃"
     "☄"
     "☎"
     "☑"
     "☘")
    "️")
   (:: "☝" (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or
     "☠"
     "☢"
     "☣"
     "☦"
     "☪"
     "☮"
     "☯"
     "☸"
     "☹"
     "☺"
     "♀"
     "♂"
     "♟"
     "♠"
     "♣"
     "♥"
     "♦"
     "♨"
     "♻"
     "♾"
     "⚒"
     "⚔"
     "⚕"
     "⚖"
     "⚗"
     "⚙"
     "⚛"
     "⚜"
     "⚠"
     "⚧"
     "⚰"
     "⚱"
     "⛈"
     "⛏"
     "⛑"
     "⛓"
     "⛩"
     "⛰"
     "⛱"
     "⛴"
     "⛷"
     "⛸")
    "️")
   (::
    "⛹"
    (:or
     (::
      (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "✂" "✈" "✉") "️")
   (:: (:or "✊" "✋") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "✌" "✍") (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "✏" "✒" "✔" "✖" "✝" "✡" "✳" "✴" "❄" "❇" "❣") "️")
   (:: "❤" (:: "️" (:or "" (:: "\u200D" (:or "🔥" "🩹")))))
   (:: (:or "➡" "⤴" "⤵" "⬅" "⬆" "⬇" "〰" "〽" "㊗" "㊙" "🅰" "🅱" "🅾" "🅿") "️")
   (::
    "🇦"
    (:or "🇨" "🇩" "🇪" "🇫" "🇬" "🇮" "🇱" "🇲" "🇴" "🇶" "🇷" "🇸" "🇹" "🇺" "🇼" "🇽" "🇿"))
   (::
    "🇧"
    (:or
     "🇦"
     "🇧"
     "🇩"
     "🇪"
     "🇫"
     "🇬"
     "🇭"
     "🇮"
     "🇯"
     "🇱"
     "🇲"
     "🇳"
     "🇴"
     "🇶"
     "🇷"
     "🇸"
     "🇹"
     "🇻"
     "🇼"
     "🇾"
     "🇿"))
   (::
    "🇨"
    (:or
     "🇦"
     "🇨"
     "🇩"
     "🇫"
     "🇬"
     "🇭"
     "🇮"
     "🇰"
     "🇱"
     "🇲"
     "🇳"
     "🇴"
     "🇵"
     "🇷"
     "🇺"
     "🇻"
     "🇼"
     "🇽"
     "🇾"
     "🇿"))
   (:: "🇩" (:or "🇪" "🇬" "🇯" "🇰" "🇲" "🇴" "🇿"))
   (:: "🇪" (:or "🇦" "🇨" "🇪" "🇬" "🇭" "🇷" "🇸" "🇹" "🇺"))
   (:: "🇫" (:or "🇮" "🇯" "🇰" "🇲" "🇴" "🇷"))
   (::
    "🇬"
    (:or
     "🇦"
     "🇧"
     "🇩"
     "🇪"
     "🇫"
     "🇬"
     "🇭"
     "🇮"
     "🇱"
     "🇲"
     "🇳"
     "🇵"
     "🇶"
     "🇷"
     "🇸"
     "🇹"
     "🇺"
     "🇼"
     "🇾"))
   (:: "🇭" (:or "🇰" "🇲" "🇳" "🇷" "🇹" "🇺"))
   (:: "🇮" (:or "🇨" "🇩" "🇪" "🇱" "🇲" "🇳" "🇴" "🇶" "🇷" "🇸" "🇹"))
   (:: "🇯" (:or "🇪" "🇲" "🇴" "🇵"))
   (:: "🇰" (:or "🇪" "🇬" "🇭" "🇮" "🇲" "🇳" "🇵" "🇷" "🇼" "🇾" "🇿"))
   (:: "🇱" (:or "🇦" "🇧" "🇨" "🇮" "🇰" "🇷" "🇸" "🇹" "🇺" "🇻" "🇾"))
   (::
    "🇲"
    (:or
     "🇦"
     "🇨"
     "🇩"
     "🇪"
     "🇫"
     "🇬"
     "🇭"
     "🇰"
     "🇱"
     "🇲"
     "🇳"
     "🇴"
     "🇵"
     "🇶"
     "🇷"
     "🇸"
     "🇹"
     "🇺"
     "🇻"
     "🇼"
     "🇽"
     "🇾"
     "🇿"))
   (:: "🇳" (:or "🇦" "🇨" "🇪" "🇫" "🇬" "🇮" "🇱" "🇴" "🇵" "🇷" "🇺" "🇿"))
   (:: "🇴" "🇲")
   (:: "🇵" (:or "🇦" "🇪" "🇫" "🇬" "🇭" "🇰" "🇱" "🇲" "🇳" "🇷" "🇸" "🇹" "🇼" "🇾"))
   (:: "🇶" "🇦")
   (:: "🇷" (:or "🇪" "🇴" "🇸" "🇺" "🇼"))
   (::
    "🇸"
    (:or
     "🇦"
     "🇧"
     "🇨"
     "🇩"
     "🇪"
     "🇬"
     "🇭"
     "🇮"
     "🇯"
     "🇰"
     "🇱"
     "🇲"
     "🇳"
     "🇴"
     "🇷"
     "🇸"
     "🇹"
     "🇻"
     "🇽"
     "🇾"
     "🇿"))
   (::
    "🇹"
    (:or "🇦" "🇨" "🇩" "🇫" "🇬" "🇭" "🇯" "🇰" "🇱" "🇲" "🇳" "🇴" "🇷" "🇹" "🇻" "🇼" "🇿"))
   (:: "🇺" (:or "🇦" "🇬" "🇲" "🇳" "🇸" "🇾" "🇿"))
   (:: "🇻" (:or "🇦" "🇨" "🇪" "🇬" "🇮" "🇳" "🇺"))
   (:: "🇼" (:or "🇫" "🇸"))
   (:: "🇽" "🇰")
   (:: "🇾" (:or "🇪" "🇹"))
   (:: "🇿" (:or "🇦" "🇲" "🇼"))
   (:: (:or "🈂" "🈷" "🌡" "🌤" "🌥" "🌦" "🌧" "🌨" "🌩" "🌪" "🌫" "🌬" "🌶" "🍽") "️")
   (:: "🎅" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "🎖" "🎗" "🎙" "🎚" "🎛" "🎞" "🎟") "️")
   (:: "🏂" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🏃" "🏄")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🏇" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🏊"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (::
    (:or "🏋" "🏌")
    (:or
     (::
      (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "🏍" "🏎" "🏔" "🏕" "🏖" "🏗" "🏘" "🏙" "🏚" "🏛" "🏜" "🏝" "🏞" "🏟") "️")
   (:: "🏳" (:: "️" (:or "" (:: "\u200D" (:or "🌈" (:: "⚧" "️"))))))
   (::
    "🏴"
    (:or
     ""
     (:: "\u200D" (:: "☠" "️"))
     (::
      "\U000E0067"
      (::
       "\U000E0062"
       (:or
        (:: "\U000E0065" (:: "\U000E006E" (:: "\U000E0067" "\U000E007F")))
        (:: "\U000E0073" (:: "\U000E0063" (:: "\U000E0074" "\U000E007F")))
        (:: "\U000E0077" (:: "\U000E006C" (:: "\U000E0073" "\U000E007F"))))))))
   (:: (:or "🏵" "🏷") "️")
   (:: "🐈" (:or "" (:: "\u200D" "⬛")))
   (:: "🐕" (:or "" (:: "\u200D" "🦺")))
   (:: "🐦" (:or "" (:: "\u200D" "⬛")))
   (:: "🐻" (:or "" (:: "\u200D" (:: "❄" "️"))))
   (:: "🐿" "️")
   (:: "👁" (:: "️" (:or "" (:: "\u200D" (:: "🗨" "️")))))
   (::
    (:or "👂" "👃" "👆" "👇" "👈" "👉" "👊" "👋" "👌" "👍" "👎" "👏" "👐" "👦" "👧")
    (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "👨"
    (:or
     ""
     (::
      "\u200D"
      (:or
       "🌾"
       "🍳"
       "🍼"
       "🎓"
       "🎤"
       "🎨"
       "🏫"
       "🏭"
       "💻"
       "💼"
       "🔧"
       "🔬"
       "🚀"
       "🚒"
       "🦯"
       "🦰"
       "🦱"
       "🦲"
       "🦳"
       "🦼"
       "🦽"
       (:: (:or "⚕" "⚖" "✈") "️")
       (:: "❤" (:: "️" (:: "\u200D" (:or "👨" (:: "💋" (:: "\u200D" "👨"))))))
       (:: "👦" (:or "" (:: "\u200D" "👦")))
       (:: "👧" (:or "" (:: "\u200D" (:or "👦" "👧"))))
       (::
        (:or "👨" "👩")
        (::
         "\u200D"
         (:or
          (:: "👦" (:or "" (:: "\u200D" "👦")))
          (:: "👧" (:or "" (:: "\u200D" (:or "👦" "👧")))))))))
     (::
      "🏻"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (:: "💋" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
         (:: "🤝" (:: "\u200D" (:: "👨" (:or "🏼" "🏽" "🏾" "🏿"))))))))
     (::
      "🏼"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (:: "💋" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
         (:: "🤝" (:: "\u200D" (:: "👨" (:or "🏻" "🏽" "🏾" "🏿"))))))))
     (::
      "🏽"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (:: "💋" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
         (:: "🤝" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏾" "🏿"))))))))
     (::
      "🏾"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (:: "💋" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
         (:: "🤝" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏿"))))))))
     (::
      "🏿"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (:: "💋" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
         (:: "🤝" (:: "\u200D" (:: "👨" (:or "🏻" "🏼" "🏽" "🏾"))))))))))
   (::
    "👩"
    (:or
     ""
     (::
      "\u200D"
      (:or
       "🌾"
       "🍳"
       "🍼"
       "🎓"
       "🎤"
       "🎨"
       "🏫"
       "🏭"
       "💻"
       "💼"
       "🔧"
       "🔬"
       "🚀"
       "🚒"
       "🦯"
       "🦰"
       "🦱"
       "🦲"
       "🦳"
       "🦼"
       "🦽"
       (:: (:or "⚕" "⚖" "✈") "️")
       (::
        "❤"
        (::
         "️"
         (:: "\u200D" (:or "👨" "👩" (:: "💋" (:: "\u200D" (:or "👨" "👩")))))))
       (:: "👦" (:or "" (:: "\u200D" "👦")))
       (:: "👧" (:or "" (:: "\u200D" (:or "👦" "👧"))))
       (::
        "👩"
        (::
         "\u200D"
         (:or
          (:: "👦" (:or "" (:: "\u200D" "👦")))
          (:: "👧" (:or "" (:: "\u200D" (:or "👦" "👧")))))))))
     (::
      "🏻"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (::
              "💋"
              (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿")))))))))
         (:: "🤝" (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏼" "🏽" "🏾" "🏿")))))))))
     (::
      "🏼"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (::
              "💋"
              (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿")))))))))
         (:: "🤝" (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏽" "🏾" "🏿")))))))))
     (::
      "🏽"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (::
              "💋"
              (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿")))))))))
         (:: "🤝" (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏾" "🏿")))))))))
     (::
      "🏾"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (::
              "💋"
              (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿")))))))))
         (:: "🤝" (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏿")))))))))
     (::
      "🏿"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿"))
             (::
              "💋"
              (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾" "🏿")))))))))
         (::
          "🤝"
          (:: "\u200D" (:or (:: (:or "👨" "👩") (:or "🏻" "🏼" "🏽" "🏾")))))))))))
   (:: (:or "👫" "👬" "👭") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "👮"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "👯" (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))
   (::
    (:or "👰" "👱")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "👲" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "👳"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "👴" "👵" "👶") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "👷"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "👸" "👼") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "💁" "💂")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "💃" "💅") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "💆" "💇")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "💏" "💑" "💪") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "📽" "🕉" "🕊" "🕯" "🕰" "🕳") "️")
   (:: "🕴" (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🕵"
    (:or
     (::
      (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "🕶" "🕷" "🕸" "🕹") "️")
   (:: "🕺" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "🖇" "🖊" "🖋" "🖌" "🖍") "️")
   (:: "🖐" (:or "️" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "🖕" "🖖") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or
     "🖥"
     "🖨"
     "🖱"
     "🖲"
     "🖼"
     "🗂"
     "🗃"
     "🗄"
     "🗑"
     "🗒"
     "🗓"
     "🗜"
     "🗝"
     "🗞"
     "🗡"
     "🗣"
     "🗨"
     "🗯"
     "🗳"
     "🗺")
    "️")
   (:: "😮" (:or "" (:: "\u200D" "💨")))
   (:: "😵" (:or "" (:: "\u200D" "💫")))
   (:: "😶" (:or "" (:: "\u200D" (:: "🌫" "️"))))
   (::
    (:or "🙅" "🙆" "🙇" "🙋")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🙌" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🙍" "🙎")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🙏" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🚣" "🚴" "🚵" "🚶")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🛀" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: "🛋" "️")
   (:: "🛌" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (:: (:or "🛍" "🛎" "🛏" "🛠" "🛡" "🛢" "🛣" "🛤" "🛥" "🛩" "🛰" "🛳") "️")
   (:: (:or "🤌" "🤏" "🤘" "🤙" "🤚" "🤛" "🤜" "🤝" "🤞" "🤟") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🤦"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "🤰" "🤱" "🤲" "🤳" "🤴") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🤵"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🤶" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🤷" "🤸" "🤹")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🤼" (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))
   (::
    (:or "🤽" "🤾")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "🥷" "🦵" "🦶") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🦸" "🦹")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🦻" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🧍" "🧎" "🧏")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (::
    "🧑"
    (:or
     ""
     (::
      "\u200D"
      (:or
       "🌾"
       "🍳"
       "🍼"
       "🎄"
       "🎓"
       "🎤"
       "🎨"
       "🏫"
       "🏭"
       "💻"
       "💼"
       "🔧"
       "🔬"
       "🚀"
       "🚒"
       "🦯"
       "🦰"
       "🦱"
       "🦲"
       "🦳"
       "🦼"
       "🦽"
       (:: (:or "⚕" "⚖" "✈") "️")
       (:: "🤝" (:: "\u200D" "🧑"))))
     (::
      "🏻"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎄"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "💋" (:: "\u200D" (:: "🧑" (:or "🏼" "🏽" "🏾" "🏿"))))
             (:: "🧑" (:or "🏼" "🏽" "🏾" "🏿"))))))
         (:: "🤝" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
     (::
      "🏼"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎄"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "💋" (:: "\u200D" (:: "🧑" (:or "🏻" "🏽" "🏾" "🏿"))))
             (:: "🧑" (:or "🏻" "🏽" "🏾" "🏿"))))))
         (:: "🤝" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
     (::
      "🏽"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎄"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "💋" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏾" "🏿"))))
             (:: "🧑" (:or "🏻" "🏼" "🏾" "🏿"))))))
         (:: "🤝" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
     (::
      "🏾"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎄"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "💋" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏿"))))
             (:: "🧑" (:or "🏻" "🏼" "🏽" "🏿"))))))
         (:: "🤝" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))
     (::
      "🏿"
      (:or
       ""
       (::
        "\u200D"
        (:or
         "🌾"
         "🍳"
         "🍼"
         "🎄"
         "🎓"
         "🎤"
         "🎨"
         "🏫"
         "🏭"
         "💻"
         "💼"
         "🔧"
         "🔬"
         "🚀"
         "🚒"
         "🦯"
         "🦰"
         "🦱"
         "🦲"
         "🦳"
         "🦼"
         "🦽"
         (:: (:or "⚕" "⚖" "✈") "️")
         (::
          "❤"
          (::
           "️"
           (::
            "\u200D"
            (:or
             (:: "💋" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾"))))
             (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾"))))))
         (:: "🤝" (:: "\u200D" (:: "🧑" (:or "🏻" "🏼" "🏽" "🏾" "🏿"))))))))))
   (:: (:or "🧒" "🧓") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🧔"
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: "🧕" (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    (:or "🧖" "🧗" "🧘" "🧙" "🧚" "🧛" "🧜" "🧝")
    (:or
     ""
     (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))
     (::
      (:or "🏻" "🏼" "🏽" "🏾" "🏿")
      (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))))
   (:: (:or "🧞" "🧟") (:or "" (:: "\u200D" (:or (:: (:or "♀" "♂") "️")))))
   (:: (:or "🫃" "🫄" "🫅" "🫰") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿"))
   (::
    "🫱"
    (:or
     ""
     (:: "🏻" (:or "" (:: "\u200D" (:: "🫲" (:or "🏼" "🏽" "🏾" "🏿")))))
     (:: "🏼" (:or "" (:: "\u200D" (:: "🫲" (:or "🏻" "🏽" "🏾" "🏿")))))
     (:: "🏽" (:or "" (:: "\u200D" (:: "🫲" (:or "🏻" "🏼" "🏾" "🏿")))))
     (:: "🏾" (:or "" (:: "\u200D" (:: "🫲" (:or "🏻" "🏼" "🏽" "🏿")))))
     (:: "🏿" (:or "" (:: "\u200D" (:: "🫲" (:or "🏻" "🏼" "🏽" "🏾")))))))
   (:: (:or "🫲" "🫳" "🫴" "🫵" "🫶") (:or "" "🏻" "🏼" "🏽" "🏾" "🏿")))))