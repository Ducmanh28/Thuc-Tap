from message.postchange_config import postchange_config
from message.prechange_config import prechange_config

def detail_config(prechange_data, postchange_data):
    msg = f"*Detail!* \n"
    pre_data = prechange_config(prechange_data)
    post_data = postchange_config(postchange_data)
    differences = {}
    all_keys = set(pre_data.keys()).union(post_data.keys())
    for key in all_keys:
        pre_value = pre_data.get(key)
        post_value = post_data.get(key)
        if pre_value != post_value:
            differences[key] = {"prechange": pre_value, "postchange": post_value}
    for key, diff in differences.items():
        msg += f"- *{key}*: Change from *{diff['prechange']}* to *{diff['postchange']}* \n"
    return msg   