----------------------------------------DST TiengViet ------------------------------
LoadPOFile("vietnamese.po", "vietnam")
_G = GLOBAL
_G.TranslateStringTable(_G.STRINGS)
--------------------------------------------------------------------------
ANNOUNCE_STRINGS = {
  -- These are not character-specific strings, but are here to ease translation
  -- Note that spaces at the beginning and end of these are important and should be preserved
  _ = {
    getArticle = function(name)
      --This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
      return string.find(name, "^[aeoiuAOIEU]") ~= nil and " một" or " một"
    end,
    --Goes into {S} if there are multiple items (plural)
    -- This isn't perfect for making plural even in English, but it's close enough
    S = "",
    STAT_NAMES = {
      Hunger = "Hunger",
      Sanity = "Sanity",
      Health = "Health",
      Wetness = "Wetness",
      Boat = "Boat",
      ["Log Meter"] = "Log Meter",
      Age = "Tuổi",
      Abigail = "Abigail",
      Inspiration = "Cảm hứng",
      Might = "Thể lực",
      --Other mod stats won't have translations, but at least we can support these
    },
    ANNOUNCE_ITEM = {
      -- This needs to reflect the translating language's grammar
      -- For example, this might become "I have 6 papyrus in this chest."
      FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",

      --One of these goes into {I_HAVE}
      I_HAVE = "Tôi có ",
      WE_HAVE = "Chúng ta có ",

      --{THIS_MANY} is a number if multiple, but singular varies a lot by language,
      -- so we use getArticle above to get it

      --{ITEM} is acquired from item.name

      --{S} uses S above

      --Goes into {IN_THIS}, if present
      IN_THIS = " trong ",

      --{CONTAINER} is acquired from container.name

      --One of these goes into {WITH}
      WITH = " với ", --if it's only one thing
      AND_THIS_ONE_HAS = ", và cái này có ", --if there are multiple, show durability of one
      AND_THIS_ONE_IS = ", và cái này có ", --if there are multiple, show durability of one

      --{PERCENT} is acquired from the item's durability

      --Goes into {DURABILITY}
      DURABILITY = " độ bền",
      FRESHNESS = " độ tươi",
      RECHARGE = " Charge",

      -- Optionally added into {PERCENT}
      REMAINING = {
        DURABILITY = "còn {AMOUNT} lần dùng", -- note that this is unused because durability is only published as a percent to clients
        FRESHNESS = "còn {AMOUNT} ngày", -- note that this is unused because perishables only publish percent to clients
        RECHARGE = "{AMOUNT} cho đến khi sạc đầy",
      },

      -- Optionally added into {ITEM} or {WITH} for thermal stones.
      HEATROCK = {
        "lạnh như băng",
        "lạnh",
        "nhiệt độ phòng",
        "ấm áp",
        "nóng",
      }
    },
    ANNOUNCE_RECIPE = {
      -- This needs to reflect the translating language's grammar
      -- Examples of what this makes:
      -- "I have a science machine pre-built and ready to place" -> pre-built
      -- "I'll make an axe." -> known and have ingredients
      -- "Can someone make me an alchemy engine? I would need a science machine for it." -> not known
      -- "We need more drying racks." -> known but don't have ingredients
      FORMAT_STRING = "{START_Q}{TO_DO}{THIS_MANY} {ITEM}{S}{PRE_BUILT}{END_Q}{I_NEED}{A_PROTO}{PROTOTYPER}{FOR_IT}.",

      --{START_Q} is for languages that match ? at both ends
      START_Q = "", --English doesn't do that

      --One of these goes into {TO_DO}
      I_HAVE = "Tui coá ", --for pre-built
      ILL_MAKE = "Tui sẽ làm ", --for known recipes where you have ingredients
      CAN_SOMEONE = "Liệu ai đó có thể giúp mình ", --for unknown recipes
      WE_NEED = "Chúng mình cần thêm ", --for known recipes where you don't have ingredients

      --{THIS_MANY} uses getArticle above to get the right article ("a", "an")

      --{ITEM} comes from the recipe.name

      --{S} uses S above

      --Goes into {PRE_BUILT}
      PRE_BUILT = " được xây dựng sẵn và sẵn sàng để đặt",

      --This goes into {END_Q} if it's a question
      END_Q = "?",

      --Goes into {I_NEED}
      I_NEED = " Tôi sẽ cần ",

      --{PROTOTYPER} is taken from the recipepopup.teaser:GetString with this function
      getPrototyper = function(teaser)
        --This extracts from sentences like "Use a (science machine) to..." and "Use an (alchemy engine) to..."
        return teaser:gmatch("Use an?? (.*) to")()
      end,

      --Goes into {FOR_IT}
      FOR_IT = " cho nó",
    },
    ANNOUNCE_INGREDIENTS = {
      -- This needs to reflect the translating language's grammar
      -- Examples of what this makes:
      -- "I need 2 more cut stones and a science machine to make an alchemy engine."
      FORMAT_NEED = "Tui cần {NUM_ING} thêm {INGREDIENT}{S}{AND}{A_PROTO}{PROTOTYPER} để làm {A_REC} {RECIPE}.",

      --If a prototyper is needed, goes into {AND}
      AND = " và ",

      -- This needs to reflect the translating language's grammar
      -- Examples of what this makes:
      -- "I have enough twigs to make 9 bird traps, but I need a science machine."
      FORMAT_HAVE = "Tôi có đủ {INGREDIENT}{ING_S} để làm {A_REC} {RECIPE}{REC_S}{BUT_NEED}{A_PROTO}{PROTOTYPER}.",

      --If a prototyper is needed, goes into {BUT_NEED}
      BUT_NEED = ", nhưng tôi cần ",
    },
    ANNOUNCE_SKIN = {
      -- This needs to reflect the translating language's grammar
      -- For example, this might become "I have the Tragic Torch skin for the Torch"
      FORMAT_STRING = "Tôi có skin {SKIN} cho {ITEM}.",

      --{SKIN} comes form the skin's name

      --{ITEM} comes from the item's name
    },
    ANNOUNCE_TEMPERATURE = {
      -- This needs to reflect the translating language's grammar
      -- For example, this might become "I'm at a comfortable temperature"
      -- or "The beast is freezing!"
      FORMAT_STRING = "{PRONOUN}{TEMPERATURE}",

      --{PRONOUN} is picked from this
      PRONOUN = {
        DEFAULT = "Tôi",
        BEAST = "Quái thú", --for Werebeaver
      },

      --{TEMPERATURE} is picked from this
      TEMPERATURE = {
        BURNING = "nóng vãiiiii!",
        HOT = "nóng thật!",
        WARM = "nóng sương sương",
        GOOD = "ổn áp phết",
        COOL = "lạnh sương sương",
        COLD = "lạnh thật!",
        FREEZING = "lạnh thấy bà nội!",
      },
    },
    ANNOUNCE_SEASON = "Còn lại {DAYS_LEFT} ngày của mùa {SEASON}.",
    ANNOUNCE_GIFT = {
      CAN_OPEN = "Tui đang có một món quà và đang chuẩn bị mở nó đây!",
      NEED_SCIENCE = "Tui cần máy khoa học để mở món quà này!",
    },
    ANNOUNCE_CIRCUITS = {
      FORMAT_STRING = "{CIRCUITS}: {CHARGED}{SEPARATOR}{UNCHARGED}.",
      FORMAT_STRING_CHARGED = "{CIRCUIT_LIST} ({CHARGE_STATE})",
      FORMAT_STRING_CHIP = "{COUNT} {CIRCUIT_NAME}",
      CIRCUITS = "Mạch điện",
      CHARGED = "Được kích hoạt",
      UNCHARGED = "Chưa được kích hoạt",
      SEPARATOR = "; ",
      GetCircuitName = function(name)
        local s, e = name:find(" Circuit")
        if s == nil then
          return name
        end
        return name:sub(1, s - 1)
      end,
    },
    ANNOUNCE_HINT = "Thông báo",
  },
  -- Everything below is character-specific
  UNKNOWN = {
    HUNGER = {
      FULL  = "Suýt bội thực luôn rồi :0",
      HIGH  = "No căng bụng trùng da mắt :>",
      MID   = "Đói sương sương, nhưng dễ hẹo lắm nếu không có đồ ăn kịp thời",
      LOW   = "Đói vãi ò, ae cứu với",
      EMPTY = "Tuyệt thực tới chết x.x",
    },
    SANITY = {
      FULL  = "Tỉnh như sáo cậy @.@",
      HIGH  = "Còn tỉnh chán, yên tâm",
      MID   = "Não thấy sắp cút rồi á :<",
      LOW   = "Não sắp cút thật rồi",
      EMPTY = "Chết não",
    },
    HEALTH = {
      FULL  = "Sẵn sàng khô máu bất cứ điều gì",
      HIGH  = "Thương có tí, chạ làm seo!!",
      MID   = "Tui sắp cút rồi ae",
      LOW   = "Thôi bú cái gì hồi máu nhanh lên chứ cút thật bây giờ tôi ơi.",
      EMPTY = "Cút luôn rồi",
    },
    WETNESS = {
      FULL  = "Ướt như chuột lột!",
      HIGH  = "Ướt!",
      MID   = "Quần áo của tôi bị ướt.",
      LOW   = "Oh, H2O.",
      EMPTY = "Khô ráo.",
    },
    BOAT = {
      FULL  = "Con thuyền này ở trong tình trạng hoàn hảo!", -- >85%
      HIGH  = "Thuyền này vẫn có thể đi biển.", -- >65%
      MID   = "Con thuyền này có một chút va đập.", -- >35%
      LOW   = "Con thuyền này đang cần sửa chữa gấp!", -- >0.01%
      EMPTY = "Con tàu này đang chìm!", -- <0.01%
    },
  },
  WILSON = {
    HUNGER = {
      FULL  = "Tôi no căng!",
      HIGH  = "Tôi không cần ăn.",
      MID   = "Tôi có thể ăn một chút.",
      LOW   = "Tôi rất đói!",
      EMPTY = "Tôi... cần... thức ăn...",
    },
    SANITY = {
      FULL  = "Tỉnh táo nhất có thể!",
      HIGH  = "Tôi sẽ ổn thôi.",
      MID   = "Đầu tôi đau...",
      LOW   = "Gì-- chuyện gì đang xảy ra!?",
      EMPTY = "Giúp! Những thứ đó sẽ ăn tôi!!",
    },
    HEALTH = {
      FULL  = "Khỏe như vâm!",
      HIGH  = "Tôi bị thương, nhưng tôi có thể tiếp tục.",
      MID   = "Tôi... tôi nghĩ mình cần sự chăm sóc y tế.",
      LOW   = "Tôi đã mất quá nhiều máu...",
      EMPTY = "Tôi... tôi sẽ không qua khỏi...",
    },
    WETNESS = {
      FULL  = "Tôi đã đạt đến điểm bão hòa!",
      HIGH  = "Cách nước đi!",
      MID   = "Quần áo của tôi có vẻ thấm nước.",
      LOW   = "Ôi, H2O.",
      EMPTY = "Tôi hơi khô.",
    },
  },
  WILLOW = {
    HUNGER = {
      FULL  = "Tôi sẽ béo nếu không ngừng ăn.",
      HIGH  = "Đầy bụng dễ chịu.",
      MID   = "Ngọn lửa của tôi cần một chút nhiên liệu.",
      LOW   = "Ugh, tôi đang đói quá!",
      EMPTY = "Tôi gần như chỉ còn da bọc xương rồi!",
    },
    SANITY = {
      FULL  = "Tôi nghĩ mình đã đủ lửa rồi.",
      HIGH  = "Có phải tôi vừa thấy Bernie đi không? ... không, thôi kệ.",
      MID   = "Tôi cảm thấy lạnh hơn bình thường...",
      LOW   = "Bernie, tại sao tôi cảm thấy lạnh như vậy!?",
      EMPTY = "Bernie, bảo vệ tôi khỏi những thứ kinh khủng đó!",
    },
    HEALTH = {
      FULL  = "Không một vết xước trên tôi!",
      HIGH  = "Tôi có vài vết xước. Có lẽ tôi nên đốt chúng.",
      MID   = "Những vết cắt này quá nặng để đốt, tôi cần bác sĩ...",
      LOW   = "Tôi cảm thấy yếu... tôi có thể... chết.",
      EMPTY = "Ngọn lửa của tôi gần như tắt...",
    },
    WETNESS = {
      FULL  = "Ugh, mưa này là TỆ nhất!",
      HIGH  = "Tôi ghét tất cả nước này!",
      MID   = "Cơn mưa này quá nhiều.",
      LOW   = "Uh oh, nếu mưa tiếp tục...",
      EMPTY = "Không đủ mưa để dập tắt lửa.",
    },
  },
  WOLFGANG = {
    HUNGER = {
      FULL  = "Wolfgang no căng và mạnh mẽ!",
      HIGH  = "Wolfgang phải ăn để trở nên mạnh mẽ hơn!",
      MID   = "Wolfgang có thể ăn thêm.",
      LOW   = "Wolfgang có lỗ trong bụng.",
      EMPTY = "Wolfgang cần thức ăn! NGAY BÂY GIỜ!",
    },
    SANITY = {
      FULL  = "Wolfgang cảm thấy tốt trong đầu!",
      HIGH  = "Wolfgang đầu cảm thấy kỳ lạ.",
      MID   = "Wolfgang đau đầu.",
      LOW   = "Wolfgang thấy quái vật đáng sợ...",
      EMPTY = "Quái vật đáng sợ ở khắp nơi!",
    },
    HEALTH = {
      FULL  = "Wolfgang không cần sửa chữa!",
      HIGH  = "Wolfgang cần chút sửa chữa.",
      MID   = "Wolfgang bị thương.",
      LOW   = "Wolfgang cần nhiều sự giúp đỡ để không bị đau.",
      EMPTY = "Wolfgang có thể chết...",
    },
    WETNESS = {
      FULL  = "Wolfgang có thể bây giờ được làm từ nước!",
      HIGH  = "Như đang ngồi trong ao.",
      MID   = "Wolfgang không thích giờ tắm.",
      LOW   = "Thời gian nước.",
      EMPTY = "Wolfgang khô.",
    },
  },
  WENDY = {
    HUNGER = {
      FULL  = "Không có lượng thức ăn nào có thể lấp đầy lỗ hổng trong trái tim tôi.",
      HIGH  = "Tôi no, nhưng vẫn đói thứ mà không bạn bè nào có thể cung cấp.",
      MID   = "Tôi không trống rỗng, nhưng không no. Kỳ lạ.",
      LOW   = "Tôi đầy sự trống rỗng.",
      EMPTY = "Tôi đã tìm thấy cách chậm nhất để chết. Đói khát.",
    },
    SANITY = {
      FULL  = "Suy nghĩ của tôi trong suốt như pha lê.",
      HIGH  = "Suy nghĩ của tôi trở nên đục.",
      MID   = "Suy nghĩ của tôi sốt sắng...",
      LOW   = "Em thấy họ không, Abigail? Những con quỷ này có thể cho phép tôi sớm tham gia cùng em.",
      EMPTY = "Đưa tôi đến Abigail, những sinh vật của bóng tối và đêm tối!",
    },
    HEALTH = {
      FULL  = "Tôi khỏe mạnh, nhưng tôi chắc chắn sẽ bị thương lại.",
      HIGH  = "Tôi cảm thấy đau, nhưng không nhiều.",
      MID   = "Cuộc sống mang lại đau đớn, nhưng tôi không quen với cơn đau này.",
      LOW   = "Chảy máu... sẽ dễ dàng hơn...",
      EMPTY = "Tôi sẽ sớm gặp Abigail...",
    },
    WETNESS = {
      FULL  = "Một ngày tận thế của nước!",
      HIGH  = "Một vĩnh hằng của độ ẩm và nỗi buồn.",
      MID   = "Ướt át và buồn bã.",
      LOW   = "Có lẽ nước này sẽ lấp đầy lỗ hổng trong trái tim tôi.",
      EMPTY = "Da tôi khô như trái tim tôi.",
    },
    ABIGAIL = {
      FULL  = "Abigail sáng hơn bao giờ hết!",
      HIGH  = "Abigail tỏa sáng rực rỡ.",
      MID   = "Abigail bắt đầu mờ dần...",
      LOW   = "Cẩn thận, Abigail! Chị gần như không thấy em nữa!",
      EMPTY = "Đừng rời xa chị, Abigail!",
    },
  },
  WX78 = {
    HUNGER = {
      FULL  = "ĐỘ NO >75%",
      HIGH  = "ĐỘ NO >55%",
      MID   = "ĐỘ NO >35%",
      LOW   = "ĐỘ NO >15%",
      EMPTY = "ĐỘ NO <15%",
    },
    SANITY = {
      FULL  = "ĐỘ TỈNH TÁO >75%",
      HIGH  = "ĐỘ TỈNH TÁO >55%",
      MID   = "ĐỘ TỈNH TÁO >35%",
      LOW   = "ĐỘ TỈNH TÁO >15%",
      EMPTY = "ĐỘ TỈNH TÁO <15%",
    },
    HEALTH = {
      FULL  = "ĐỘ HƯ HỎNG <15%",
      HIGH  = "ĐỘ HƯ HỎNG >15%",
      MID   = "ĐỘ HƯ HỎNG >35%",
      LOW   = "ĐỘ HƯ HỎNG >55%",
      EMPTY = "ĐỘ HƯ HỎNG =100%",
    },
    WETNESS = {
      FULL  = "NGUY CƠ GÂY CHẬP >75%",
      HIGH  = "NGUY CƠ GÂY CHẬP >55%",
      MID   = "NGUY CƠ GÂY CHẬP >35%",
      LOW   = "NGUY CƠ GÂY CHẬP >15%",
      EMPTY = "NGUY CƠ GÂY CHẬP <15%",
    },
  },
  WICKERBOTTOM = {
    HUNGER = {
      FULL  = "Tôi nên nghiên cứu thay vì tự làm mình no căng.",
      HIGH  = "Đầy, nhưng không quá no.",
      MID   = "Tôi cảm thấy hơi đói.",
      LOW   = "Thủ thư này cần thức ăn, tôi sợ đấy!",
      EMPTY = "Nếu không có thức ăn ngay lập tức, tôi sẽ chết đói!",
    },
    SANITY = {
      FULL  = "Không có gì bất thường ở đây.",
      HIGH  = "Tôi tin rằng mình bị đau đầu.",
      MID   = "Những cơn đau đầu này không chịu nổi.",
      LOW   = "Tôi không chắc những thứ đó còn tưởng tượng nữa!",
      EMPTY = "Giúp! Những quái vật không thể hiểu nổi này đang tấn công!",
    },
    HEALTH = {
      FULL  = "Tôi khỏe nhất có thể theo tuổi của mình!",
      HIGH  = "Vài vết bầm, nhưng không gì nghiêm trọng.",
      MID   = "Nhu cầu y tế của tôi đang tăng lên.",
      LOW   = "Không điều trị, đây sẽ là kết thúc của tôi.",
      EMPTY = "Tôi cần sự chăm sóc y tế ngay lập tức!",
    },
    WETNESS = {
      FULL  = "Hoàn toàn ướt sũng!",
      HIGH  = "Tôi ướt sũng, sũng, sũng!",
      MID   = "Tôi tự hỏi điểm bão hòa của cơ thể mình là bao nhiêu...",
      LOW   = "Lớp nước bắt đầu tích tụ.",
      EMPTY = "Tôi khô ráo hoàn toàn.",
    },
  },
  WOODIE = {
    HUMAN = {
      HUNGER = {
        FULL  = "No căng rồi!",
        HIGH  = "Vẫn đủ no để chặt cây.",
        MID   = "Có thể cần một bữa ăn nhẹ, eh!",
        LOW   = "Chuông ăn tối kêu rồi!",
        EMPTY = "Tôi đang đói lắm!",
      },
      SANITY = {
        FULL  = "Tất cả đều ổn ở phía Bắc!",
        HIGH  = "Vẫn ổn trong đầu.",
        MID   = "Tôi nghĩ mình cần ngủ một chút, eh!",
        LOW   = "Đi khỏi đi, những thứ ác mộng đáng ghét!",
        EMPTY = "Tất cả những nỗi sợ của tôi đều là thật và đau đớn!",
      },
      HEALTH = {
        FULL  = "Khỏe như còi!",
        HIGH  = "Cái gì không giết bạn sẽ làm bạn mạnh mẽ hơn, eh?",
        MID   = "Có thể cần một chút sức khỏe.",
        LOW   = "Đó thực sự bắt đầu đau, eh...",
        EMPTY = "Đặt tôi nghỉ ngơi... trong rừng...",
      },
      WETNESS = {
        FULL  = "Quá ướt thậm chí không thể chặt cây, eh?",
        HIGH  = "Áo sơ mi không đủ cho loại mưa này.",
        MID   = "Tôi đang ướt khá nhiều, eh?",
        LOW   = "Áo sơ mi ấm, ngay cả khi ướt.",
        EMPTY = "Hầu như không có giọt nào trên tôi, eh?",
      },
      ["LOG METER"] = {
        FULL  = "Có thể luôn cần thêm gỗ, nhưng không trong bụng tôi ngay bây giờ, eh?", -- > 90%
        HIGH  = "Tôi thèm một cái gì đó giống như cành cây.", -- > 70%
        MID   = "Gỗ trông rất ngon miệng.", -- > 50%
        LOW   = "Tôi có thể cảm thấy lời nguyền sắp đến.", -- > 25%
        EMPTY = "Mraw, eh?", -- < 25% (điều này không nên xảy ra, anh ta sẽ trở thành người sói hải ly)
      },
    },
    WEREBEAVER = {
      SANITY = {
        FULL  = "Đôi mắt của con thú mở to và tỉnh táo.",
        HIGH  = "Con thú chớp mắt với những cái bóng.",
        MID   = "Con thú quay lại nhìn thứ gì đó không tồn tại.",
        LOW   = "Con thú đang run rẩy và mắt nó giật giật.",
        EMPTY = "Con thú gầm gừ và dường như bị săn đuổi bởi những cái bóng đang nhân lên.",
      },
      HEALTH = {
        FULL  = "Con thú chạy nhảy hăng hái.",
        HIGH  = "Con thú có vài vết trầy xước.",
        MID   = "Con thú liếm vết thương.",
        LOW   = "Con thú ôm cánh tay của nó.",
        EMPTY = "Con thú đi khập khiễng thảm hại.",
      },
      WETNESS = {
        FULL  = "Lông của con thú hoàn toàn ướt sũng.",
        HIGH  = "Con thú để lại một vệt nước nhỏ.",
        MID   = "Lông của con thú hơi ướt.",
        LOW   = "Con thú nhỏ giọt một chút.",
        EMPTY = "Lông của con thú khô.",
      },
      ["LOG METER"] = {
        FULL  = "Con thú trông gần như con người.", -- > 90%
        HIGH  = "Con thú nhai một miếng gỗ đầy miệng.", -- > 70%
        MID   = "Con thú nhai một cái cành cây.", -- > 50%
        LOW   = "Con thú nhìn chằm chằm vào những cái cây với sự thèm khát.", -- > 25%
        EMPTY = "Con thú trông rỗng tuếch.", -- < 25%
      },
    },
  },
  WES = {
    HUNGER = {
      FULL  = "...",
      HIGH  = "...",
      MID   = "...",
      LOW   = "...",
      EMPTY = "...",
    },
    SANITY = {
      FULL  = "...",
      HIGH  = "...",
      MID   = "...",
      LOW   = "...",
      EMPTY = "...",
    },
    HEALTH = {
      FULL  = "...",
      HIGH  = "...",
      MID   = "...",
      LOW   = "...",
      EMPTY = "...",
    },
    WETNESS = {
      FULL  = "...",
      HIGH  = "...",
      MID   = "...",
      LOW   = "...",
      EMPTY = "...",
    },
  },
  WAXWELL = {
    HUNGER = {
      FULL  = "Ta đã có một bữa tiệc khá lớn.",
      HIGH  = "Ta no, nhưng không quá mức.",
      MID   = "Có lẽ cần một bữa ăn nhẹ.",
      LOW   = "Ta cảm thấy trống rỗng bên trong.",
      EMPTY = "Không! Ta không kiếm được tự do chỉ để chết đói ở đây!",
    },
    SANITY = {
      FULL  = "Tỉnh táo nhất có thể.",
      HIGH  = "Trí tuệ không dao động của ta dường như đang... dao động.",
      MID   = "Ugh. Đầu ta đau.",
      LOW   = "Ta cần làm rõ đầu óc, ta bắt đầu thấy... Chúng.",
      EMPTY = "Giúp ta! Những bóng tối này là những con quái vật thực sự, bạn biết đấy!",
    },
    HEALTH = {
      FULL  = "Ta hoàn toàn không bị thương.",
      HIGH  = "Chỉ là một vết xước.",
      MID   = "Ta có thể cần băng bó lại.",
      LOW   = "Đây không phải là bài hát thiên nga của ta, nhưng ta đang gần kề.",
      EMPTY = "Không! Ta không trốn thoát chỉ để chết ở đây!",
    },
    WETNESS = {
      FULL  = "Ướt hơn cả nước.",
      HIGH  = "Ta nghĩ ta sẽ không bao giờ khô lại.",
      MID   = "Nước này sẽ làm hỏng bộ đồ của ta.",
      LOW   = "Ẩm ướt không hề sang trọng.",
      EMPTY = "Khô ráo và sang trọng.",
    },
  },

  WEBBER = {
    HUNGER = {
      FULL  = "Cả hai dạ dày của chúng tôi đều no!", -- >75%
      HIGH  = "Chúng tôi có thể ăn thêm một chút nữa.", -- >55%
      MID   = "Chúng tôi nghĩ đã đến giờ ăn trưa!", -- >35%
      LOW   = "Chúng tôi sẽ ăn thức ăn thừa của mẹ vào lúc này...", -- >15%
      EMPTY = "Dạ dày của chúng tôi trống rỗng!", -- <15%
    },
    SANITY = {
      FULL  = "Chúng tôi cảm thấy rất nghỉ ngơi!", -- >75%
      HIGH  = "Một giấc ngủ ngắn sẽ không hại gì.", -- >55%
      MID   = "Đầu của chúng tôi đau...", -- >35%
      LOW   = "Lần cuối chúng tôi ngủ là khi nào?!", -- >15%
      EMPTY = "Chúng tôi không sợ các ngươi, những thứ đáng sợ!", -- <15%
    },
    HEALTH = {
      FULL  = "Chúng tôi thậm chí không có một vết trầy xước!", -- 100%
      HIGH  = "Chúng tôi sẽ cần một băng keo.", -- >75%
      MID   = "Chúng tôi sẽ cần nhiều hơn một băng keo...", -- >50%
      LOW   = "Cơ thể của chúng tôi đau nhức...", -- >25%
      EMPTY = "Chúng tôi không muốn chết...", -- <25%
    },
    WETNESS = {
      FULL  = "Waah, chúng tôi ướt sũng!", -- >75%
      HIGH  = "Lông của chúng tôi bị ướt sũng!", -- >55%
      MID   = "Chúng tôi ướt!", -- >35%
      LOW   = "Chúng tôi ẩm ướt không thoải mái.", -- >15%
      EMPTY = "Chúng tôi thích chơi trong vũng nước.", -- <15%
    },
  },
  WATHGRITHR = {
    HUNGER = {
      FULL  = "Tôi khao khát trận chiến, không phải thịt!", -- >75%
      HIGH  = "Tôi đủ no để chiến đấu.", -- >55%
      MID   = "Tôi có thể ăn một món ăn nhẹ bằng thịt.", -- >35%
      LOW   = "Tôi khao khát một bữa tiệc!", -- >15%
      EMPTY = "Tôi sẽ chết đói nếu không có chút thịt!", -- <15%
    },
    SANITY = {
      FULL  = "Tôi không sợ con người!", -- >75%
      HIGH  = "Tôi sẽ cảm thấy tốt hơn trong trận chiến!", -- >55%
      MID   = "Tâm trí tôi lang thang...", -- >35%
      LOW   = "Những cái bóng này xuyên qua ngọn giáo của tôi...", -- >15%
      EMPTY = "Tránh xa, những con quái vật của bóng tối!", -- <15%
    },
    HEALTH = {
      FULL  = "Da tôi không thể xuyên thủng!", -- 100%
      HIGH  = "Chỉ là vết thương nhẹ thôi!", -- >75%
      MID   = "Tôi bị thương, nhưng tôi vẫn có thể chiến đấu.", -- >50%
      LOW   = "Không có sự trợ giúp, tôi sẽ sớm đến Valhalla...", -- >25%
      EMPTY = "Câu chuyện của tôi kết thúc...", -- <25%
    },
    WETNESS = {
      FULL  = "Tôi hoàn toàn ướt sũng!", -- >75%
      HIGH  = "Một chiến binh ướt sũng không thể chiến đấu!", -- >55%
      MID   = "Giáp của tôi sẽ bị gỉ!", -- >35%
      LOW   = "Tôi sẽ không cần tắm sau này.", -- >15%
      EMPTY = "Khô ráo đủ để chiến đấu!", -- <15%
    },
    INSPIRATION = {
      FULL = "Giọng tôi đủ mạnh để hát ba bài!", -- >5/6, 3 songs
      HIGH = "Tôi có thể hát song ca một mình!", -- >3/6, 2 songs
      MID  = "Tôi sẵn sàng hát!", -- >1/6, 1 song
      LOW  = "Tôi phải khởi động giọng... trong trận chiến!", -- <1/6
    },
  },
  WINONA = {
    HUNGER = {
      FULL  = "Tôi đã có bữa ăn đầy đủ cho ngày.",
      HIGH  = "Tôi luôn có chỗ cho thêm thức ăn!",
      MID   = "Tôi có thể nghỉ trưa chưa?",
      LOW   = "Tôi sắp hết nhiên liệu rồi, sếp.",
      EMPTY = "Nhà máy sẽ thiếu công nhân nếu tôi không có thức ăn!",
    },
    SANITY = {
      FULL  = "Tỉnh táo nhất có thể.",
      HIGH  = "Mọi thứ đều tốt dưới mui xe!",
      MID   = "Tôi nghĩ tôi có vài ốc vít lỏng...",
      LOW   = "Tâm trí tôi hỏng, tôi nên là người sửa nó.",
      EMPTY = "Đây là ác mộng! Ha! Thực sự vậy.",
    },
    HEALTH = {
      FULL  = "Tôi khỏe như ngựa!",
      HIGH  = "Eh, tôi sẽ làm việc để khỏe hơn.",
      MID   = "Tôi không thể bỏ cuộc.",
      LOW   = "Tôi có thể nhận lương hưu chưa...?",
      EMPTY = "Tôi nghĩ ca làm của tôi kết thúc...",
    },
    WETNESS = {
      FULL  = "Tôi không thể làm việc trong điều kiện này!",
      HIGH  = "Quần yếm của tôi đang đọng nước!",
      MID   = "Ai đó nên đặt biển báo sàn ướt.",
      LOW   = "Luôn tốt để giữ ẩm khi làm việc.",
      EMPTY = "Chuyện nhỏ thôi.",
    },
  },
  WARLY = {
    HUNGER = {
      FULL  = "Món ăn của tôi sẽ giết tôi!", -- >75%
      HIGH  = "Tôi nghĩ tôi đã đủ rồi, tạm thời.", -- >55%
      MID   = "Đã đến giờ ăn tối với món tráng miệng.", -- >35%
      LOW   = "Tôi đã bỏ lỡ giờ ăn tối!", -- >15%
      EMPTY = "Chết đói... cái chết tồi tệ nhất!", -- <15%
    },
    SANITY = {
      FULL  = "Hương thơm tuyệt vời của món ăn giúp tôi tỉnh táo.", -- >75%
      HIGH  = "Tôi cảm thấy hơi choáng.", -- >55%
      MID   = "Tôi không thể nghĩ thông suốt.", -- >35%
      LOW   = "Những tiếng thì thầm... giúp tôi!", -- >15%
      EMPTY = "Tôi không thể chịu nổi sự điên rồ này!", -- <15%
    },
    HEALTH = {
      FULL  = "Tôi hoàn toàn khỏe mạnh.", -- 100%
      HIGH  = "Tôi đã chịu đựng nhiều hơn khi cắt hành.", -- >75%
      MID   = "Tôi đang chảy máu...", -- >50%
      LOW   = "Tôi cần sự giúp đỡ!", -- >25%
      EMPTY = "Đoán đây là kết thúc, bạn cũ...", -- <25%
    },
    WETNESS = {
      FULL  = "Tôi có thể cảm thấy cá bơi trong áo.", -- >75%
      HIGH  = "Nước sẽ làm hỏng những món ăn hoàn hảo của tôi!", -- >55%
      MID   = "Tôi nên phơi khô quần áo trước khi bị cảm.", -- >35%
      LOW   = "Đây không phải thời gian hay nơi để tắm.", -- >15%
      EMPTY = "Chỉ vài giọt trên người, không sao.", -- <15%
    },
  },
  WALANI = {
    HUNGER = {
      FULL  = "Suýt bội thực luôn rồi :0",
      HIGH  = "No căng bụng trùng da mắt :>",
      MID   = "Đói sương sương, nhưng dễ hẹo lắm nếu không có đồ ăn kịp thời",
      LOW   = "Đói vãi ò, ae cứu với",
      EMPTY = "Tuyệt thực tới chết x.x",
    },
    SANITY = {
      FULL  = "Tỉnh như sáo cậy @.@",
      HIGH  = "Còn tỉnh chán, yên tâm",
      MID   = "Não thấy sắp cút rồi á :<",
      LOW   = "Não sắp cút thật rồi",
      EMPTY = "Chết não",
    },
    HEALTH = {
      FULL  = "Sẵn sàng khô máu bất cứ điều gì",
      HIGH  = "Thương có tí, chạ làm seo!!",
      MID   = "Tui sắp cút rồi ae",
      LOW   = "Thôi bú cái gì hồi máu nhanh lên chứ cút thật bây giờ tôi ơi.",
      EMPTY = "Cút luôn rồi",
    },
    WETNESS = {
      FULL  = "Ướt như chuột lột!",
      HIGH  = "Ướt!",
      MID   = "Quần áo của tôi bị ướt.",
      LOW   = "Oh, H2O.",
      EMPTY = "Khô ráo.",
    },
  },
  WOODLEGS = {
    HUNGER = {
      FULL  = "Yarr, đó là một bữa ăn ngon, cậu bé!", -- >75%
      HIGH  = "Tôi đã khá no bụng.", -- >55%
      MID   = "Đã đến lúc cho bữa ăn hàng ngày.", -- >35%
      LOW   = "Aye! Bọn nhóc, đồ ăn của tôi đâu!?", -- >15%
      EMPTY = "Tôi đang chết đói!", -- <15%
    },
    SANITY = {
      FULL  = "Aye, biển cả, nàng thật đẹp!", -- >75%
      HIGH  = "Đã đến lúc ra khơi!", -- >55%
      MID   = "Tôi nhớ biển của mình...", -- >35%
      LOW   = "Không nhớ lần cuối tôi ra khơi.", -- >15%
      EMPTY = "Tôi là thuyền trưởng cướp biển cầm kiếm, không phải kẻ ở đất liền!", -- <15%
    },
    HEALTH = {
      FULL  = "Yarr, tôi là một kẻ cứng đầu!", -- 100%
      HIGH  = "Chỉ có vậy thôi sao?", -- >75%
      MID   = "Tôi chưa bỏ cuộc đâu!", -- >50%
      LOW   = "Woodlegs không phải là kẻ hèn nhát!", -- >25%
      EMPTY = "Arr! Bạn thắng, tên côn đồ!", -- <25%
    },
    WETNESS = {
      FULL  = "Tôi ướt đến tận xương!", -- >75%
      HIGH  = "Tôi thích nước ở dưới thuyền của mình hơn.", -- >55%
      MID   = "Áo cướp biển của tôi đang thấm nước.", -- >35%
      LOW   = "Quần của tôi bị ướt!", -- >15%
      EMPTY = "Arr! Một cơn bão đang hình thành.", -- <15%
    },
  },
  WILBUR = {
    HUNGER = {
      FULL  = "*nhảy quanh vỗ tay*", -- >75%
      HIGH  = "*vỗ tay vui vẻ*", -- >55%
      MID   = "*xoa bụng*", -- >35%
      LOW   = "*trông buồn và xoa bụng*", -- >15%
      EMPTY = "OOAOE! *xoa bụng*", -- <15%
    },
    SANITY = {
      FULL  = "*gõ vào đầu*", -- >75%
      HIGH  = "*giơ ngón cái*", -- >55%
      MID   = "*trông sợ hãi*", -- >35%
      LOW   = "*kêu lên đầy ám ảnh*", -- >15%
      EMPTY = "OOAOE! OOOAH!", -- <15%
    },
    HEALTH = {
      FULL  = "*đập ngực bằng cả hai tay*", -- 100%
      HIGH  = "*đập ngực*", -- >75%
      MID   = "*nhẹ nhàng xoa những mảng lông mất*", -- >50%
      LOW   = "*khập khiễng khổ sở*", -- >25%
      EMPTY = "OAOOE! OOOOAE!", -- <25%
    },
    WETNESS = {
      FULL  = "*hắt xì*", -- >75%
      HIGH  = "*chà xát tay*", -- >55%
      MID   = "Ooo! Ooae!", -- >35%
      LOW   = "Oooh?", -- >15%
      EMPTY = "Ooae Oooh Oaoa! Ooooe.", -- <15%
    },
  },
  WORMWOOD = {
    HUNGER = {
      FULL  = "TÔI LÀ GROOOOTTTTTT!!!!",
      HIGH  = "GROOT GRRROOOT",
      MID   = "Tôi là Groot",
      LOW   = "tôi là gro-",
      EMPTY = "---",
    },
    SANITY = {
      FULL  = "TÔI LÀ GROOOOTTTTTT!!!!",
      HIGH  = "GROOT GRRROOOT",
      MID   = "Tôi là Groot",
      LOW   = "tôi là gro-",
      EMPTY = "---",
    },
    HEALTH = {
      FULL  = "TÔI LÀ GROOOOTTTTTT!!!!",
      HIGH  = "GROOT GRRROOOT",
      MID   = "Tôi là Groot",
      LOW   = "tôi là gro-",
      EMPTY = "---",
    },
    WETNESS = {
      FULL  = "TÔI LÀ GROOOOTTTTTT!!!!",
      HIGH  = "GROOT GRRROOOT",
      MID   = "Tôi là Groot",
      LOW   = "tôi là gro-",
      EMPTY = "---",
    },
  },
  WURT = {
    HUNGER = {
      FULL  = "No lắm rồi, fờ lọp",
      HIGH  = "No...có thể ngừng, fờ lọt",
      MID   = "Hơi đói,fờ phọp",
      LOW   = "Rất đói,Blop flop",
      EMPTY = "Chết...vì đói",
    },
    SANITY = {
      FULL  = "Tỉnh táo, fờ lọp",
      HIGH  = "Tàm tạm, bình thường",
      MID   = "Phờ lọp",
      LOW   = "Ma... sợ quá",
      EMPTY = "Sợ quá... ác mọng",
    },
    HEALTH = {
      FULL  = "Không bị đau, fờ lọp",
      HIGH  = "Bị xước nhẹ, flợp",
      MID   = "Đau....",
      LOW   = "Đau....quá",
      EMPTY = "Cút luôn rồi",
    },
    WETNESS = {
      FULL  = "Nước, flọp, nhiều khi quên mình là cá",
      HIGH  = "Ờ nước...flọp",
      MID   = "Bị ướt rồi, flọt",
      LOW   = "Ô nước kìa....",
      EMPTY = "Khô ráo.",
    }
  },
  WORTOX = {
    HUNGER = {
      FULL  = "Thật là phàm trần khi có một cái bụng đầy!",
      HIGH  = "Tôi đã được nạp năng lượng cho một trò đùa tốt! Hyuyu!",
      MID   = "Cần một miếng ăn... rất phàm trần.",
      LOW   = "Tôi rất thích một linh hồn ngon lành! Tôi sẽ để dành trò đùa cho sau...",
      EMPTY = "Cơn thèm linh hồn của tôi đã trở nên dữ dội!",
    },
    SANITY = {
      FULL  = "Đầu óc tôi minh mẫn... những thời gian vui vẻ sắp đến! Hyuyu!",
      HIGH  = "Tôi có thể hút vài linh hồn để giữ đầu óc tỉnh táo?",
      MID   = "Tất cả những lần nhảy của tôi đã gây ra cơn đau đầu...",
      LOW   = "Tôi ghen tị với những trò lừa của những cái bóng này! Hyuyu!",
      EMPTY = "Tâm trí tôi đang ở trong một cõi hoàn toàn điên loạn!",
    },
    HEALTH = {
      FULL  = "Tôi đang trong tâm trạng hoàn hảo cho một trò nghịch ngợm tốt!",
      HIGH  = "Chỉ là một vết xước, không gì mà một linh hồn không thể khôi phục!",
      MID   = "Vài linh hồn để làm lành những vết thương này... Hyuyu!",
      LOW   = "Linh hồn của chính tôi đang yếu dần...",
      EMPTY = "Linh hồn của tôi sắp không còn là của tôi! Hyuyu...",
    },
    WETNESS = {
      FULL  = "TÔI ĐANG BỊ ƯỚT ĐẪM!",
      HIGH  = "Tôi là con quỷ ướt nhất!",
      MID   = "Có một mùi ướt của con quỷ trong tương lai của tôi.",
      LOW   = "Thế giới đang tắm cho tôi!",
      EMPTY = "Tôi nên để mắt đến bầu trời, nếu tôi muốn khô ráo!",
    }
  },
  WANDA = {
    HUNGER = {
      FULL  = "Ta cần thời gian để tiêu hóa hết thức ăn này!", -- >75%
      HIGH  = "Ta vẫn còn no từ trước đó. Hoặc sau đó.", -- >55%
      MID   = "Ta có đủ thời gian cho một bữa ăn nhẹ!", -- >35%
      LOW   = "Dạ dày của ta là một dòng thời gian riêng!", -- >15%
      EMPTY = "Thời gian sẽ đuổi kịp ta nhanh chóng nếu ta không ăn ngay bây giờ!", -- <15%
    },
    SANITY = {
      FULL  = "Mọi thứ trông bình thường trong dòng thời gian này!", -- >75%
      HIGH  = "Cảm thấy tuyệt vời đủ để thực hiện những bước nhảy lượng tử!", -- >55%
      MID   = "Nếu ta không mang theo đồng hồ, ta sẽ không biết thời gian là gì nữa!", -- >35%
      LOW   = "Thực tại đang tan vỡ!", -- >15%
      EMPTY = "Ngươi sẽ không bao giờ bắt được ta! Quá khứ, hiện tại, hay tương lai!", -- <15%
    },
    HEALTH = {
      FULL  = "Người ta nói tuổi 20 là những năm tuyệt nhất của cuộc đời!", -- 100%
      HIGH  = "Vẫn còn trẻ và đầy sức sống!", -- >75%
      MID   = "Chờ một chút! Ta cần thời gian để hồi phục!", -- >50%
      LOW   = "Ta chỉ cần thêm thời gian!", -- >25%
      EMPTY = "Cát trong đồng hồ cát của ta sắp hết rồi!", -- <25%
    },
    WETNESS = {
      FULL  = "Thời gian giống như cơn mưa này. Nó không bao giờ ngừng!", -- >75%
      HIGH  = "Nếu tiếp tục thế này, đồng hồ bỏ túi của ta sẽ bị gỉ sét!", -- >55%
      MID   = "Đã bao nhiêu năm rồi kể từ khi ta ướt đẫm như thế này?", -- >35%
      LOW   = "Ôi chao! Ta cần tìm nơi trú khỏi cơn mưa này!", -- >15%
      EMPTY = "Một chút mưa chẳng là gì so với những phức tạp của du hành thời gian!", -- <15%
    }
  },
  WALTER = {
    HUNGER = {
      FULL  = "Này Woby, ăn dùm anh cái chứ no lắm rồi :<",
      HIGH  = "Này Woby, để anh tìm xem có gì cho em ăn đỡ một chút không chứ anh đủ no rồi :>",
      MID   = "Tự dưng thấy đoi đói nhỉ, mọi người có chút đồ ăn không xin với.",
      LOW   = "Đói quá, mọi người, Woby ơi, trông...em... thôi quên đi!",
      EMPTY = "Tuyệt thực tới chết!",
    },
    SANITY = {
      FULL  = "Woby ơi, hãy đi kiếm vài con ác ma để làm nền cho câu chuyện tối nay nào!",
      HIGH  = "Thấy mệt chưa, Woby, anh vẫn ổn, mọi người thì sao?",
      MID   = "Tự dưng mình thấy hơi buồn ngủ!!",
      LOW   = "Ôi váng đầu quá!",
      EMPTY = "Chết não",
    },
    HEALTH = {
      FULL  =
      "Mặc dù không bị tổn thương thể xác gì cả nhưng tui dễ bị tổn thương tinh thần lắm á, tốt nhất là việc oánh nhau tui để cho mọi người giải quyết teehee~",
      HIGH  = "A ah ahhh... đau quá Woby, đưa cho anh MỘT CÁI băng gạc cá nhân với!",
      MID   = "AHHHHH... Chu-mi-na... not kìn-chá-nà cứu tôi với!",
      LOW   = "Ôí dồi ôi, Làng nước ơi, ba má ơi, cứu con với, con sắp chớt rồi, cứuuuuuu vớiiiii, WODYYYY CHẠY ĐIIIII",
      EMPTY = "Thôi tạm biệt trần thế...",
    },
    WETNESS = {
      FULL  = "Ha ha nhìn em kìa, Woby trông em cứ như chổi lau nhà ý, ờm... anh cũng vậy, hêh",
      HIGH  = "Uớt át quá đi~",
      MID   = "Woby, hay em hoá to để anh chui xuống trú mưa đi !! hehe",
      LOW   = "Hình như trời đang mưa, hay nước ở đâu bắn vào mình ý nhỉ?",
      EMPTY = "Khô tanh, hehe",
    }
  }
}
