extends Reference

# {
#     "loot_tables": {
#         <loot_table_id>: [
#             {
#                 "name": <pool_name>,
#                 "entries": [
#                     {
#                         "type": ("item"|"loot_table"),
#                         "type_id": (<item_name>|<loot_table_id>),
#                         "chance": (0.0-1.0),
#                         "count": [<chance>, <count>]
#                     }
#                 ]
#             }
#         ]
#     }
# }

var _pools: Array = Array()
var _id: String = String()

static func load_from_json
