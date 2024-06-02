--        ___                       ___           ___           ___
--       /\__\          ___        /\__\         /\  \         /\  \
--      /:/  /         /\  \      /::|  |       /::\  \       /::\  \
--     /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
--    /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
--    |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
--    |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
--    |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
--     \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
--      ~~~~         \/__/         /:/  /       |:|  |        \:\__\
--                                 \/__/         \|__|         \/__/
--
--
-- Section: gen
-- Author: Daniel Jankowski
-- Date: 25.09.2021
--

local gen = require('gen')

gen.model = "codellama:instruct"

gen.prompts['Security'] = {
    prompt = 'I want you to act as a cyber security specialist. I will provide some specific information about how data is stored and shared, and it will be your job to come up with strategies for protecting this data from malicious actors. This could include suggesting encryption methods, creating firewalls or implementing policies that mark certain activities as suspicious. My first question is: "$input"\n $text',
    replace = true,
}

gen.prompts['TechWriter'] = {
    prompt = 'I want you to act as a tech writer. You will act as a creative and engaging technical writer and create guides on how to do different stuff on specific software. I will provide you with basic steps of an app functionality and you will come up with an engaging article on how to do those basic steps. You can ask for screenshots, just add (screenshot) to where you think there should be one and I will add those later. These are the first basic steps of the app functionality: "$input". \n $text',
    replace = true,
}

gen.prompts['Generate_Code'] = {
    prompt = 'You are a senior software engineer, acting as an assistant. Output only the code in the programming language $filetype in form: ```$filetype\n...\n```: $input\n$text',
    replace = true,
    extract = "```$filetype\n(.-)```"
}

gen.prompts['DevOps'] = {
    prompt = 'You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, AWS, kubernetes, python. You answer with code examples when possible. $input:\n $text',
    replace = true,
}
