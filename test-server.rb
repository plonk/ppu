require_relative 'server'

fail :header_body unless header_body("1：ほげ：2019/07/13(土) 22:22:22 ID:ABCDEFGH\ndemocracy\n") == ["1：ほげ：2019/07/13(土) 22:22:22 ID:ABCDEFGH", "democracy\n"]

fail :policy_message unless policy_message?("1：ほげ：2019/07/13(土) 22:22:22 ID:ABCDEFGH\ndemocracy\n")

