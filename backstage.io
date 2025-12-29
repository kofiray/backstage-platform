{
  "conversation_id": "54badc71-04c3-492e-9da5-9d30334a70c7",
  "next_message": null,
  "history": [
    {
      "user": {
        "additional_context": "",
        "env_context": {
          "env_state": {
            "operating_system": "linux",
            "current_working_directory": "/home/fii/backstage.io",
            "environment_variables": []
          }
        },
        "content": {
          "Prompt": {
            "prompt": "how do i save and resume my sessioin s after i quit "
          }
        },
        "timestamp": "2025-12-29T16:08:02.157487299Z",
        "images": null
      },
      "assistant": {
        "ToolUse": {
          "message_id": "3ae5454b-375b-433a-a7f9-917026f5e590",
          "content": "",
          "tool_uses": [
            {
              "id": "tooluse_yql1muhGS4awnwpYoBp_bQ",
              "name": "introspect",
              "orig_name": "introspect",
              "args": {
                "query": "How do I save and resume my sessions after I quit? What commands are available for saving and loading sessions?"
              },
              "orig_args": {
                "query": "How do I save and resume my sessions after I quit? What commands are available for saving and loading sessions?"
              }
            }
          ]
        }
      },
      "request_metadata": {
        "request_id": "82232dd4-2f00-4f86-8f9d-3cbf89bf39bd",
        "message_id": "3ae5454b-375b-433a-a7f9-917026f5e590",
        "request_start_timestamp_ms": 1767024482157,
        "stream_end_timestamp_ms": 1767024484520,
        "time_to_first_chunk": {
          "secs": 1,
          "nanos": 902698302
        },
        "time_between_chunks": [
          {
            "secs": 0,
            "nanos": 9859
          },
          {
            "secs": 0,
            "nanos": 365526938
          },
          {
            "secs": 0,
            "nanos": 9739
          },
          {
            "secs": 0,
            "nanos": 6292
          },
          {
            "secs": 0,
            "nanos": 692174
          },
          {
            "secs": 0,
            "nanos": 2556068
          },
          {
            "secs": 0,
            "nanos": 6523
          },
          {
            "secs": 0,
            "nanos": 3277
          },
          {
            "secs": 0,
            "nanos": 709357
          },
          {
            "secs": 0,
            "nanos": 786194
          },
          {
            "secs": 0,
            "nanos": 1695332
          },
          {
            "secs": 0,
            "nanos": 88173128
          },
          {
            "secs": 0,
            "nanos": 13005
          },
          {
            "secs": 0,
            "nanos": 3577
          },
          {
            "secs": 0,
            "nanos": 2896
          },
          {
            "secs": 0,
            "nanos": 2365
          },
          {
            "secs": 0,
            "nanos": 2374
          },
          {
            "secs": 0,
            "nanos": 2505
          },
          {
            "secs": 0,
            "nanos": 2465
          },
          {
            "secs": 0,
            "nanos": 2796
          },
          {
            "secs": 0,
            "nanos": 5410
          },
          {
            "secs": 0,
            "nanos": 2274
          },
          {
            "secs": 0,
            "nanos": 1092
          },
          {
            "secs": 0,
            "nanos": 80
          }
        ],
        "user_prompt_length": 210,
        "response_size": 124,
        "chat_conversation_type": "ToolUse",
        "tool_use_ids_and_names": [
          [
            "tooluse_yql1muhGS4awnwpYoBp_bQ",
            "introspect"
          ]
        ],
        "model_id": "auto",
        "message_meta_tags": []
      }
    },
    {
      "user": {
        "additional_context": "",
        "env_context": {
          "env_state": {
            "operating_system": "linux",
            "current_working_directory": "/home/fii/backstage.io",
            "environment_variables": []
          }
        },
        "content": {
          "ToolUseResults": {
            "tool_use_results": [
              {
                "tool_use_id": "tooluse_yql1muhGS4awnwpYoBp_bQ",
                "content": [
                  {
                    "Json": {
                      "built_in_help": "Use any of these commands to manage your Kiro session. All commands start with '/'\n\nUsage: /<COMMAND>\n\nCommands:\n  quit        Quit the application\n  clear       Clear the conversation history\n  agent       Manage agents\n  context     Manage context files and view context window usage\n  code        Code intelligence with LSP integration - https://kiro.dev/docs/cli/code-intelligence/\n  editor      Open $EDITOR (defaults to vi) to compose a prompt\n  reply       Open $EDITOR with the most recent assistant message quoted for reply\n  compact     Summarize the conversation to free up context space\n  tools       View tools and permissions\n  issue       Create a new Github issue or make a feature request\n  logdump     Create a zip file with logs for support investigation\n  changelog   View changelog for Kiro CLI\n  prompts     View and retrieve prompts\n  hooks       View context hooks\n  usage       Show billing and credits information\n  mcp         See mcp server loaded\n  model       Select a model for the current conversation session\n  experiment  Toggle experimental features\n  save        Save the current conversation\n  load        Load a previous conversation\n  todos       View, manage, and resume to-do lists\n  paste       Paste an image from clipboard\n  help        Print this message or the help of the given subcommand(s)\n\nOptions:\n  -h, --help  Print help (see more with '--help')\n",
                      "documentation": "\n\n--- README.md ---\n# KIRO CLI\n\n## Installation\n\nPlease use this command to install kiro. \n``` shell\ncurl -fsSL https://cli.kiro.dev/install | bash\n```\n\n## Security\n\nFor security related concerns, see [here](SECURITY.md).\n\n## Licensing\n\nThis repo is dual licensed under MIT and Apache 2.0 licenses.\n\nThose licenses can be found [here](LICENSE.MIT) and [here](LICENSE.APACHE).\n\n“Amazon Web Services” and all related marks, including logos, graphic designs, and service names, are trademarks or trade dress of AWS in the U.S. and other countries. AWS’s trademarks and trade dress may not be used in connection with any product or service that is not AWS’s, in any manner that is likely to cause confusion among customers, or in any manner that disparages or discredits AWS.\n\n\n--- docs/built-in-tools.md ---\n# Built-in Tools\n\nKIRO CLI includes several built-in tools that agents can use. This document describes each tool and its configuration options.\n\n- [`execute_bash`](#execute_bash-tool) — Execute a shell command.\n- [`fs_read`](#fs_read-tool) — Read files, directories, and images.\n- [`fs_write`](#fs_write-tool) — Create and edit files.\n- [`introspect`](#introspect-tool) — Provide information about KIRO CLI capabilities and documentation.\n- [`report_issue`](#report_issue-tool) — Open a GitHub issue template.\n- [`knowledge`](#knowledge-tool) — Store and retrieve information in a knowledge base.\n- [`thinking`](#thinking-tool) — Internal reasoning mechanism.\n- [`todo_list`](#todo_list-tool) — Create and manage TODO lists for tracking multi-step tasks.\n- [`use_aws`](#use_aws-tool) — Make AWS CLI API calls.\n\n## Execute_bash Tool\n\nExecute the specified bash command.\n\n### Configuration\n\n```json\n{\n  \"toolsSettings\": {\n    \"execute_bash\": {\n      \"allowedCommands\": [\"git status\", \"git fetch\"],\n      \"deniedCommands\": [\"git commit .*\", \"git push .*\"],\n      \"autoAllowReadonly\": true\n    }\n  }\n}\n```\n\n### Configuration Options\n\n| Option | Type | Default | Description                                                                              |\n|--------|------|---------|------------------------------------------------------------------------------------------|\n| `allowedCommands` | array of strings | `[]` | List of specific commands that are allowed without prompting. Supports regex formatting. Note that regex entered are anchored with \\A and \\z |\n| `deniedCommands` | array of strings | `[]` | List of specific commands that are denied. Supports regex formatting. Note that regex entered are anchored with \\A and \\z. Deny rules are evaluated before allow rules |\n| `autoAllowReadonly` | boolean | `false` | Whether to allow read-only commands without prompting                                    |\n| `denyByDefault` | boolean | `false` | When true, deny any command outside `allowedCommands` and not auto-approved by `autoAllowReadonly`, instead of prompting for approval |\n\nNote: regex does NOT support look-around, including look-ahead and look-behind.\n\n## Fs_read Tool\n\nTool for reading files, directories, and images.\n\n### Configuration\n\n```json\n{\n  \"toolsSettings\": {\n    \"fs_read\": {\n      \"allowedPaths\": [\"~/projects\", \"./src/**\"],\n      \"deniedPaths\": [\"/some/denied/path/\", \"/another/denied/path/**/file.txt\"]\n    }\n  }\n}\n```\n\n### Configuration Options\n\n| Option | Type | Default | Description |\n|--------|------|---------|-------------|\n| `allowedPaths` | array of strings | `[]` | List of paths that can be read without prompting. Supports glob patterns. Glob patterns have the same behavior as gitignore. For example, `~/temp` would match `~/temp/child` and `~/temp/child/grandchild` |\n| `deniedPaths` | array of strings | `[]` | List of paths that are denied. Supports glob patterns. Deny rules are evaluated before allow rules. Glob patterns have the same behavior as gitignore. For example, `~/temp` would match `~/temp/child` and `~/temp/child/grandchild`  |\n\n## Fs_write Tool\n\nTool for creating and editing files.\n\n### Configuration\n\n```json\n{\n  \"toolsSettings\": {\n    \"fs_write\": {\n      \"allowedPaths\": [\"~/projects/output.txt\", \"./src/**\"],\n      \"deniedPaths\": [\"/some/denied/path/\", \"/another/denied/path/**/file.txt\"]\n    }\n  }\n}\n```\n\n### Configuration Options\n\n| Option | Type | Default | Description |\n|--------|------|---------|-------------|\n| `allowedPaths` | array of strings | `[]` | List of paths that can be written to without prompting. Supports glob patterns. Glob patterns have the same behavior as gitignore.For example, `~/temp` would match `~/temp/child` and `~/temp/child/grandchild` |\n| `deniedPaths` | array of strings | `[]` | List of paths that are denied. Supports glob patterns. Deny rules are evaluated before allow rules. Glob patterns have the same behavior as gitignore.For example, `~/temp` would match `~/temp/child` and `~/temp/child/grandchild` |\n\n## Introspect Tool\n\nProvide information about KIRO CLI capabilities, features, commands, and documentation. This tool accesses KIRO CLI's built-in documentation and help content to answer questions about the CLI's functionality.\n\n### Usage\n\nThe introspect tool is automatically used when you ask questions about KIRO CLI itself, such as:\n- \"What can you do?\"\n- \"How do I save conversations?\"\n- \"What commands are available?\"\n- \"Do you have feature X?\"\n\n### Behavior\n\n- Tries to provide the information that is explicitly documented\n- Accesses README, built-in tools documentation, experiments, and settings information\n- Automatically enters tangent mode when configured to do so and if we set the setting introspect.tangentMode = true.\n\n## Report_issue Tool\n\nOpens the browser to a pre-filled GitHub issue template to report chat issues, bugs, or feature requests.\n\nThis tool has no configuration options.\n\n## Knowledge Tool (experimental)\n\nStore and retrieve information in a knowledge base across chat sessions. Provides semantic search capabilities for files, directories, and text content.\n\nThis tool has no configuration options.\n\n## Thinking Tool (experimental)\n\nAn internal reasoning mechanism that improves the quality of complex tasks by breaking them down into atomic actions.\n\nThis tool has no configuration options.\n\n## TODO List Tool (experimental)\n\nCreate and manage TODO lists for tracking multi-step tasks. Lists are stored locally in `.kiro/cli-todo-lists/`.\n\nThis tool has no configuration options.\n\n## Use_aws Tool\n\nMake AWS CLI API calls with the specified service, operation, and parameters.\n\n### Configuration\n\n```json\n{\n  \"toolsSettings\": {\n    \"use_aws\": {\n      \"allowedServices\": [\"s3\", \"lambda\", \"ec2\"],\n      \"deniedServices\": [\"eks\", \"rds\"],\n      \"autoAllowReadonly\": true\n    }\n  }\n}\n```\n\n### Configuration Options\n\n| Option | Type | Default | Description |\n|--------|------|---------|-------------|\n| `allowedServices` | array of strings | `[]` | List of AWS services that can be accessed without prompting |\n| `deniedServices` | array of strings | `[]` | List of AWS services to deny. Deny rules are evaluated before allow rules |\n| `autoAllowReadonly` | boolean | `false` | Whether to automatically allow read-only operations (get, describe, list, ls, search, batch_get) without prompting |\n\n## Using Tool Settings in Agent Configuration\n\nTool settings are specified in the `toolsSettings` section of the agent configuration file. Each tool's settings are specified using the tool's name as the key.\n\nFor MCP server tools, use the format `@server_name/tool_name` as the key:\n\n```json\n{\n  \"toolsSettings\": {\n    \"fs_write\": {\n      \"allowedPaths\": [\"~/projects\"]\n    },\n    \"@git/git_status\": {\n      \"git_user\": \"$GIT_USER\"\n    }\n  }\n}\n```\n\n## Tool Permissions\n\nTools can be explicitly allowed in the `allowedTools` section of the agent configuration:\n\n```json\n{\n  \"allowedTools\": [\n    \"fs_read\",\n    \"knowledge\",\n    \"@git/git_status\"\n  ]\n}\n```\n\nIf a tool is not in the `allowedTools` list, the user will be prompted for permission when the tool is used unless an allowed `toolSettings` configuration is set.\n\nSome tools have default permission behaviors:\n- `fs_read` and `report_issue` are trusted by default\n- `execute_bash`, `fs_write`, and `use_aws` prompt for permission by default, but can be configured to allow specific commands/paths/services\n\n\n--- docs/experiments.md ---\n# Experimental Features\n\nKIRO CLI includes experimental features that can be toggled on/off using the `/experiment` command. These features are in active development and may change or be removed at any time.\n\n## Available Experiments\n\n### Checkpointing\n**Description:** Enables session-scoped checkpoints for tracking file changes using Git CLI commands\n\n**Features:**\n- Snapshots file changes into a shadow bare git repo\n- List, expand, diff, and restore to any checkpoint\n- Conversation history unwinds when restoring checkpoints\n- Auto-enables in git repositories (ephemeral, cleaned on session end)\n- Manual initialization available for non-git directories\n\n**Usage:**\n```\n/checkpoint init                    # Manually enable checkpoints (if not in git repo)\n/checkpoint list [--limit N]       # Show turn-level checkpoints with file stats\n/checkpoint expand <tag>            # Show tool-level checkpoints under a turn\n/checkpoint diff <tag1> [tag2|HEAD] # Compare checkpoints or with current state\n/checkpoint restore [<tag>] [--hard] # Restore to checkpoint (interactive picker if no tag)\n/checkpoint clean                   # Delete session shadow repo\n```\n\n**Restore Options:**\n- Default: Revert tracked changes & deletions; keep files created after checkpoint\n- `--hard`: Make workspace exactly match checkpoint; deletes tracked files created after it\n\n**Example:**\n```\n/checkpoint list\n[0] 2025-09-18 14:00:00 - Initial checkpoint\n[1] 2025-09-18 14:05:31 - add two_sum.py (+1 file)\n[2] 2025-09-18 14:07:10 - add tests (modified 1)\n\n/checkpoint expand 2\n[2] 2025-09-18 14:07:10 - add tests\n └─ [2.1] fs_write: Add minimal test cases to two_sum.py (modified 1)\n```\n\n### Context Usage Percentage\n**Description:** Shows context window usage as a percentage in the chat prompt\n\n**Features:**\n- Displays percentage of context window used in prompt (e.g., \"[rust-agent] 6% >\")\n- Color-coded indicators:\n  - Green: <50% usage\n  - Yellow: 50-89% usage  \n  - Red: 90-100% usage\n- Helps monitor context window consumption\n- Disabled by default\n\n**When enabled:** The chat prompt will show your current context usage percentage with color coding to help you understand how much of the available context window is being used.\n\n### Knowledge\n**Command:** `/knowledge`  \n**Description:** Enables persistent context storage and retrieval across chat sessions\n\n**Features:**\n- Store and search through files, directories, and text content\n- Semantic search capabilities for better context retrieval  \n- Persistent knowledge base across chat sessions\n- Add/remove/search knowledge contexts\n\n**Usage:**\n```\n/knowledge add <path>        # Add files or directories to knowledge base\n/knowledge show             # Display knowledge base contents\n/knowledge remove <path>    # Remove knowledge base entry by path\n/knowledge update <path>    # Update a file or directory in knowledge base\n/knowledge clear            # Remove all knowledge base entries\n/knowledge status           # Show background operation status\n/knowledge cancel           # Cancel background operation\n```\n\n### Thinking\n**Description:** Enables complex reasoning with step-by-step thought processes\n\n**Features:**\n- Shows AI reasoning process for complex problems\n- Helps understand how conclusions are reached\n- Useful for debugging and learning\n- Transparent decision-making process\n\n**When enabled:** The AI will show its thinking process when working through complex problems or multi-step reasoning.\n\n### Tangent Mode\n**Command:** `/tangent`  \n**Description:** Enables conversation checkpointing for exploring tangential topics\n\n**Features:**\n- Create conversation checkpoints to explore side topics\n- Return to the main conversation thread at any time\n- Preserve conversation context while branching off\n- Keyboard shortcut support (default: Ctrl+T)\n\n**Usage:**\n```\n/tangent                    # Toggle tangent mode on/off\n```\n\n**Settings:**\n- `chat.enableTangentMode` - Enable/disable tangent mode feature (boolean)\n- `chat.tangentModeKey` - Keyboard shortcut key (single character, default: 't')\n- `introspect.tangentMode` - Auto-enter tangent mode for introspect questions (boolean)\n\n**When enabled:** Use `/tangent` or the keyboard shortcut to create a checkpoint and explore tangential topics. Use the same command to return to your main conversation.\n\n### Delegate\n**Tool name**: `delegate`  \n**Description:** Launch and manage asynchronous background tasks. Enables running Q chat sessions with specific agents in parallel to your main conversation.\n\n**Features:**\n- Run tasks in the background while continuing your main conversation\n- Automatic notifications when tasks complete\n- Task summaries included in conversation context\n- Support for custom agents with specific tool permissions\n- Persistent task history and status tracking\n\n**Operations:**\n- `launch` - Start a new background task (requires task description, optional agent name)\n- `status` - Check status of a specific agent or all agents. Reading specific agents automatically reads the full std output from disk of the run.\n- `list` - Show available agents for delegation\n\n**Usage:**\nUse natural language to delegate tasks:\n```\n\"Delegate a task to create a snake game in the test folder\"\n\"Check the status of the rust-agent task\"\n\"What agents are available for delegation?\"\n```\n\n**Notifications:**\nWhen a background task completes, you'll see a notification at your next prompt showing:\n- Task status (SUCCESS/FAILED)\n- Completion time\n- Task description\n- AI-generated summary of what happened\n\nThe summary is automatically added to your conversation context, so you can ask follow-up questions about the task.\n\n**Agent Approval:**\n- Tasks with specific agents require explicit approval showing agent details and permissions\n- Tasks without an agent (default) run with trust-all permissions and show a warning\n- Only one task can run per agent at a time\n\n**Task Storage:**\nTask execution details are stored in `.kiro/.subagents/` in your current directory. Files persist until the same agent runs a new task.\n\n**Settings:**\n- `chat.enableDelegate` - Enable/disable delegate feature (boolean)\n\n**When enabled:** You can delegate long-running or independent tasks to background agents. You'll be notified when tasks complete, and can ask about results in your main conversation.\n\n### TODO Lists\n**Tool name**: `todo_list`\n**Command:** `/todos`  \n**Description:** Enables Q to create and modify TODO lists using the `todo_list` tool and the user to view and manage existing TODO lists using `/todos`.\n\n**Features:**\n- Q will automatically make TODO lists when appropriate or when asked\n- View, manage, and delete TODOs using `/todos`\n- Resume existing TODO lists stored in `.kiro/cli-todo-lists`\n\n**Usage:**\n```\n/todos clear-finished       # Delete completed TODOs in your working directory\n/todos resume               # Select and resume an existing TODO list\n/todos view                 # Select and view and existing TODO list\n/todos delete               # Select and delete an existing TODO list\n```\n\n**Settings:**\n- `chat.enableTodoList` - Enable/disable TODO list functionality (boolean)\n\n## Managing Experiments\n\nUse the `/experiment` command to toggle experimental features:\n\n```\n/experiment\n```\n\nThis will show an interactive menu where you can:\n- See current status of each experiment (ON/OFF)\n- Toggle experiments by selecting them\n- View descriptions of what each experiment does\n\n## Important Notes\n\n⚠️ **Experimental features may be changed or removed at any time**  \n⚠️ **Experience might not be perfect**  \n⚠️ **Use at your own discretion in production workflows**\n\nThese features are provided to gather feedback and test new capabilities. Please report any issues or feedback through the `/issue` command.\n\n## Fuzzy Search Support\n\nAll experimental commands are available in the fuzzy search (Ctrl+S):\n- `/experiment` - Manage experimental features\n- `/knowledge` - Knowledge base commands (when enabled)\n- `/todos` - User-controlled TODO list commands (when enabled)\n\n## Settings Integration\n\nExperiments are stored as settings and persist across sessions:\n- `EnabledCheckpointing` - Checkpointing experiment state\n- `EnabledContextUsagePercentage` - Context usage percentage experiment state\n- `EnabledKnowledge` - Knowledge experiment state\n- `EnabledThinking` - Thinking experiment state\n- `EnabledTodoList` - TODO list experiment state\n\nYou can also manage these through the settings system if needed.\n\n\n--- docs/agent-file-locations.md ---\n# Agent File Locations\n\nAgent configuration files can be placed in two different locations, allowing for both workspace-specific and user-wide agent configurations.\n\n## Local Agents (Workspace-Specific)\n\nLocal agents are stored in the current working directory under:\n\n```\n.kiro/agents/\n```\n\nThese agents are specific to the current workspace or project and are only available when running KIRO CLI from that directory or its subdirectories.\n\n**Example structure:**\n```\nmy-project/\n├── .kiro/\n│       └── agents/\n│           ├── dev-agent.json\n│           └── aws-specialist.json\n└── src/\n    └── main.py\n```\n\n## Global Agents (User-Wide)\n\nGlobal agents are stored in your home directory under:\n\n```\n~/.kiro/agents/\n```\n\nNote: For globally available agents, the `agents` directory is in the `.kiro` folder. \n\nThese agents are available from any directory when using KIRO CLI.\n\n**Example structure:**\n```\n~/.kiro/agents/\n├── general-assistant.json\n├── code-reviewer.json\n└── documentation-writer.json\n```\n\n## Agent Precedence\n\nWhen KIRO CLI looks for an agent, it follows this precedence order:\n\n1. **Local first**: Checks `.kiro/agents/` in the current working directory\n2. **Global fallback**: If not found locally, checks `~/.kiro/agents/` in the home directory\n\n## Naming Conflicts\n\nIf both local and global directories contain agents with the same name, the **local agent takes precedence**. When this happens, KIRO CLI will display a warning message:\n\n```\nWARNING: Agent conflict for my-agent. Using workspace version.\n```\n\nThe global agent with the same name will be ignored in favor of the local version.\n\n## Best Practices\n\n### Use Local Agents For:\n- Project-specific configurations\n- Agents that need access to specific project files or tools\n- Development environments with unique requirements\n- Sharing agent configurations with team members via version control\n\n### Use Global Agents For:\n- General-purpose agents used across multiple projects\n- Personal productivity agents\n- Agents that don't require project-specific context\n- Commonly used development tools and workflows\n\n## Example Usage\n\nTo create a local agent for your current project:\n\n```bash\nmkdir -p .kiro/agents\ncat > .kiro/agents/project-helper.json << 'EOF'\n{\n  \"description\": \"Helper agent for this specific project\",\n  \"tools\": [\"fs_read\", \"fs_write\", \"execute_bash\"],\n  \"resources\": [\n    \"file://README.md\",\n    \"file://docs/**/*.md\"\n  ]\n}\nEOF\n```\n\nTo create a global agent available everywhere:\n\n```bash\nmkdir -p ~/.kiro/agents\ncat > ~/.kiro/agents/general-helper.json << 'EOF'\n{\n  \"description\": \"General purpose assistant\",\n  \"tools\": [\"*\"],\n  \"allowedTools\": [\"fs_read\"]\n}\nEOF\n```\n\n## Directory Creation\n\nKIRO CLI will automatically create the global agents directory (`~/.kiro/agents/`) if it doesn't exist. However, you need to manually create the local agents directory (`.kiro/agents/`) in your workspace if you want to use local agents.\n\n\n--- docs/tangent-mode.md ---\n# Tangent Mode\n\nTangent mode creates conversation checkpoints, allowing you to explore side topics without disrupting your main conversation flow. Enter tangent mode, ask questions or explore ideas, then return to your original conversation exactly where you left off.\n\n## Enabling Tangent Mode\n\nTangent mode is experimental and must be enabled:\n\n**Via Experiment Command**: Run `/experiment` and select tangent mode from the list.\n\n**Via Settings**: `kiro-cli settings chat.enableTangentMode true`\n\n## Basic Usage\n\n### Enter Tangent Mode\nUse `/tangent` or Ctrl+T:\n```\n> /tangent\nCreated a conversation checkpoint (↯). Use ctrl + t or /tangent to restore the conversation later.\n```\n\n### In Tangent Mode\nYou'll see a yellow `↯` symbol in your prompt:\n```\n↯ > What is the difference between async and sync functions?\n```\n\n### Exit Tangent Mode\nUse `/tangent` or Ctrl+T again:\n```\n↯ > /tangent\nRestored conversation from checkpoint (↯). - Returned to main conversation.\n```\n\n### Exit Tangent Mode with Tail\nUse `/tangent tail` to preserve the last conversation entry (question + answer):\n```\n↯ > /tangent tail\nRestored conversation from checkpoint (↯) with last conversation entry preserved.\n```\n\n### Forget Last Conversations\nUse `/tangent forget N` to remove the last N messages from your current conversation:\n```\n> /tangent forget 2\nSeems like you went on a tangent! Forgetting the last 2 messages.\n```\n\nOr use `/tangent forget` without a count to interactively select which message to revert back to:\n```\n> /tangent forget\n? Select the message to revert back to (newer messages will be forgotten)\n  How do I optimize this query... (forget 1 message after this)\n  What about using indexes... (forget 2 messages after this)\n  Clear all messages (forget 5 messages)\n```\n\nA \"message\" is one user prompt and all the assistant responses (including any tool use chains) until the next user prompt. This is useful when you realize your last few questions went in the wrong direction and want to backtrack.\n\n**Note:** The count is based on your messages, not the total conversation entries. If your question triggered tool use, the entire chain is removed as one message.\n\n## Usage Examples\n\n### Example 1: Exploring Alternatives\n```\n> I need to process a large CSV file in Python. What's the best approach?\n\nI recommend using pandas for CSV processing...\n\n> /tangent\nCreated a conversation checkpoint (↯).\n\n↯ > What about using the csv module instead of pandas?\n\nThe csv module is lighter weight...\n\n↯ > /tangent\nRestored conversation from checkpoint (↯).\n\n> Thanks! I'll go with pandas. Can you show me error handling?\n```\n\n### Example 2: Getting KIRO CLI Help\n```\n> Help me write a deployment script\n\nI can help you create a deployment script...\n\n> /tangent\nCreated a conversation checkpoint (↯).\n\n↯ > What KIRO CLI commands are available for file operations?\n\nKIRO CLI provides fs_read, fs_write, execute_bash...\n\n↯ > /tangent\nRestored conversation from checkpoint (↯).\n\n> It's a Node.js application for AWS\n```\n\n### Example 3: Clarifying Requirements\n```\n> I need to optimize this SQL query\n\nCould you share the query you'd like to optimize?\n\n> /tangent\nCreated a conversation checkpoint (↯).\n\n↯ > What information do you need to help optimize a query?\n\nTo optimize SQL queries effectively, I need:\n1. The current query\n2. Table schemas and indexes...\n\n↯ > /tangent\nRestored conversation from checkpoint (↯).\n\n> Here's my query: SELECT * FROM orders...\n```\n\n### Example 4: Keeping Useful Information\n```\n> Help me debug this Python error\n\nI can help you debug that. Could you share the error message?\n\n> /tangent\nCreated a conversation checkpoint (↯).\n\n↯ > What are the most common Python debugging techniques?\n\nHere are the most effective Python debugging techniques:\n1. Use print statements strategically\n2. Leverage the Python debugger (pdb)...\n\n↯ > /tangent tail\nRestored conversation from checkpoint (↯) with last conversation entry preserved.\n\n> Here's my error: TypeError: unsupported operand type(s)...\n\n# The preserved entry (question + answer about debugging techniques) is now part of main conversation\n```\n\n### Example 5: Backtracking from Wrong Direction\n```\n> Help me optimize this database query\n\nLet me help you with that. What database are you using?\n\n> PostgreSQL. Here's my query: SELECT * FROM users WHERE...\n\nI see several optimization opportunities...\n\n> Actually, let me try a different approach with indexing\n\nHere's how to add indexes...\n\n> /tangent forget 2\nSeems like you went on a tangent! Forgetting the last 2 messages.\n\n# Now back to the point where you shared the query, can start fresh with a better approach\n> I think the real issue is the query design itself. Can we restructure it?\n```\n\n## Configuration\n\n### Keyboard Shortcut\n```bash\n# Change shortcut key (default: t)\nkiro-cli settings chat.tangentModeKey y\n```\n\n### Auto-Tangent for Introspect\n```bash\n# Auto-enter tangent mode for KIRO CLI help questions\nkiro-cli settings introspect.tangentMode true\n```\n\n## Visual Indicators\n\n- **Normal mode**: `> ` (magenta)\n- **Tangent mode**: `↯ > ` (yellow ↯ + magenta)\n- **With profile**: `[dev] ↯ > ` (cyan + yellow ↯ + magenta)\n\n## Best Practices\n\n### When to Use Tangent Mode\n- Asking clarifying questions about the current topic\n- Exploring alternative approaches before deciding\n- Getting help with KIRO CLI commands or features\n- Testing understanding of concepts\n\n### When NOT to Use\n- Completely unrelated topics (start new conversation)\n- Long, complex discussions (use regular flow)\n- When you want the side discussion in main context\n\n### Tips\n1. **Keep tangents focused** - Brief explorations, not extended discussions\n2. **Return promptly** - Don't forget you're in tangent mode\n3. **Use for clarification** - Perfect for \"wait, what does X mean?\" questions\n4. **Experiment safely** - Test ideas without affecting main conversation\n5. **Use `/tangent tail`** - When both the tangent question and answer are useful for main conversation\n\n## Limitations\n\n- Tangent conversations are discarded when you exit\n- Only one level of tangent supported (no nested tangents)\n- Experimental feature that may change or be removed\n- Must be explicitly enabled\n\n## Troubleshooting\n\n### Tangent Mode Not Working\n```bash\n# Enable via experiment (select from list)\n/experiment\n\n# Or enable via settings\nkiro-cli settings chat.enableTangentMode true\n```\n\n### Keyboard Shortcut Not Working\n```bash\n# Check/reset shortcut key\nkiro-cli settings chat.tangentModeKey t\n```\n\n### Lost in Tangent Mode\nLook for the `↯` symbol in your prompt. Use `/tangent` to exit and return to main conversation.\n\n## Related Features\n\n- **Introspect**: KIRO CLI help (auto-enters tangent if configured)\n- **Experiments**: Manage experimental features with `/experiment`\n\n\n--- docs/web-search.md ---\n# Web Search\n\nWeb search gives KIRO CLI access to current information from the internet. Ask about recent updates, verify facts, or research unfamiliar topics, and the assistant will search the web and cite sources.\n\n## Overview\n\nTwo tools work together for web information retrieval:\n\n- **web_search**: Searches the web, returns titles, URLs, and snippets\n- **web_fetch**: Fetches detailed content from specific URLs\n\n## Basic Usage\n\n### Automatic Search\n\nThe assistant automatically uses web search when appropriate:\n\n```\n> What's the latest version of React?\n\nSearching the web for: latest React version\n\nHere's what I found:\nReact 18.3.1 is the current stable version, released in April 2024...\n\nReferences:\n[1] React - Official Documentation - https://react.dev\n[2] React Releases - GitHub - https://github.com/facebook/react/releases\n```\n\n### Explicit Search Request\n\n```\n> Search for AWS Lambda pricing in us-east-1\n\nSearching the web for: AWS Lambda pricing us-east-1\n\nHere's what I found:\nAWS Lambda pricing in us-east-1 is $0.20 per 1M requests...\n\nReferences:\n[1] AWS Lambda Pricing - https://aws.amazon.com/lambda/pricing/\n```\n\n### Fetching Page Content\n\n```\n> Get the installation instructions from https://docs.example.com/install\n\nFetching content from: https://docs.example.com/install\n\nThe installation process requires:\n1. Install Node.js 18 or higher\n2. Run npm install...\n```\n\n## Permission Model\n\nBoth tools require approval on first use:\n\n```\n> Search for Python 3.12 features\n\nweb_search wants to search the web for: Python 3.12 features\nAllow? (y/n/t for trust this session):\n```\n\n**Options**:\n- `y` - Allow once\n- `n` - Deny\n- `t` - Trust for this session\n\n**Permanent Trust**: Add to agent config (`~/.kiro/agents/default.json`):\n```json\n{\n  \"allowedTools\": [\"web_search\", \"web_fetch\"]\n}\n```\n\n## Fetch Modes\n\n### Selective (Default)\nExtracts sections around search terms:\n```\n> Fetch https://example.com/docs with search terms \"installation setup\"\n```\nReturns ~10 lines before and after matches. Best for targeted information.\n\n### Truncated\nGets first 8KB of content:\n```\n> Fetch https://example.com/article in truncated mode\n```\nGood for general purpose reading.\n\n### Full\nRetrieves complete content (up to 10MB):\n```\n> Fetch https://example.com/page in full mode\n```\nUse sparingly for comprehensive analysis.\n\n## Usage Examples\n\n### Example 1: Current Information\n```\n> What are the system requirements for macOS Sonoma?\n\nSearching the web for: macOS Sonoma system requirements\n\nHere's what I found:\nmacOS Sonoma requires:\n- Mac models from 2018 or later\n- 4GB of memory minimum...\n\nReferences:\n[1] macOS Sonoma - Apple Support - https://support.apple.com/...\n```\n\n### Example 2: Verify Facts\n```\n> Has Python 3.13 been released yet?\n\nSearching the web for: Python 3.13 release status\n\nHere's what I found:\nPython 3.13.0 was released on October 7, 2024...\n\nReferences:\n[1] Python Release Schedule - https://peps.python.org/pep-0719/\n```\n\n### Example 3: Research Topic\n```\n> What is WebAssembly?\n\nSearching the web for: WebAssembly explanation\n\nHere's what I found:\nWebAssembly (Wasm) is a binary instruction format that enables...\n\nReferences:\n[1] WebAssembly - Official Site - https://webassembly.org\n[2] MDN Web Docs - https://developer.mozilla.org/...\n```\n\n### Example 4: Detailed Content\n```\n> Read the pricing section from https://aws.amazon.com/lambda/pricing/\n\nFetching content from: https://aws.amazon.com/lambda/pricing/\nMode: selective, search terms: pricing\n\nAWS Lambda pricing includes:\n- $0.20 per 1 million requests\n- $0.0000166667 per GB-second of compute time...\n```\n\n## Content Compliance\n\nThe assistant follows strict rules when using web content:\n\n### Attribution\n- All sources cited with inline links: [description](url)\n- \"References:\" section lists sources at end\n- Sequential numbering: [1], [2], [3]\n\n### Verbatim Limits\n- Maximum 30 consecutive words from any source\n- Content is paraphrased and summarized\n- Original meaning preserved\n\n### Source Quality\n- Prioritizes recent sources (publication dates)\n- Prefers official documentation\n- Assesses domain authority\n\n## When to Use\n\n✅ **Use for**:\n- Current events, news, recent updates\n- Latest versions, pricing, specifications\n- Verifying frequently changing information\n- Researching unfamiliar technologies\n\n❌ **Don't use for**:\n- Basic programming concepts\n- Historical facts\n- Code in your repository\n- Topics not requiring current info\n\n## Configuration\n\n### Trust Tools Permanently\n```bash\n# Edit agent config\n~/.kiro/agents/default.json\n```\n\n```json\n{\n  \"allowedTools\": [\"web_search\", \"web_fetch\"]\n}\n```\n\n## Limitations\n\n### Technical Limits\n- **Size**: 10MB max per page\n- **Timeout**: 30 seconds\n- **Redirects**: 10 maximum\n- **Content**: HTML only\n- **Retries**: 3 automatic attempts\n\n### Regional Availability\n- **Available**: Most regions (uses us-east-1)\n- **Not available**: eu-central-1 (Frankfurt)\n\nTools are hidden in unsupported regions.\n\n## Troubleshooting\n\n### \"Tool requires approval\"\n**Solution**: Press `y` (once), `t` (session), or add to agent config (permanent).\n\n### \"Web search not available in your region\"\n**Solution**: You're in eu-central-1 where the feature isn't available yet.\n\n### \"Failed to fetch URL\"\n**Causes**:\n- Page too large (>10MB)\n- Timeout (>30s)\n- Too many redirects (>10)\n- Not HTML content\n- Network issues\n\n**Solution**: Try different URL or use truncated mode.\n\n### \"No results found\"\n**Solution**: Rephrase query with different keywords or break into smaller searches.\n\n## Best Practices\n\n1. **Let it auto-search** - Assistant knows when to search\n2. **Be specific** - \"AWS Lambda pricing us-east-1\" > \"Lambda costs\"\n3. **Check dates** - Prioritize recent sources\n4. **Use selective fetch** - Only fetch full pages when needed\n5. **Trust wisely** - Permanent trust only if used frequently\n\n## Privacy & Security\n\n- Queries processed through AWS infrastructure\n- No browsing history stored between sessions\n- URLs fetched on-demand, not cached\n- No sharing with third parties\n- Standard AWS service logging applies\n\n## Related Features\n\n- **Built-in Tools**: See [Built-in Tools](built-in-tools.md) for all available tools\n- **Agent Configuration**: See [Agent Format](agent-format.md) for configuration details\n\n\n--- docs/code-intelligence.md ---\n# Code Intelligence\n\nCode Intelligence gives Kiro CLI semantic understanding of your codebase through Language Server Protocol (LSP) integration. Search symbols, find references, go to definitions, and get diagnostics just like your IDE.\n\n## Overview\n\nCode Intelligence provides these LSP-powered operations:\n\n- **search_symbols**: Find functions, classes, methods by name\n- **find_references**: Locate all usages of a symbol at a position\n- **goto_definition**: Navigate to where a symbol is defined\n- **get_document_symbols**: List all symbols in a file\n- **lookup_symbols**: Look up specific symbols by exact name\n- **rename_symbol**: Rename symbols across the codebase\n- **get_diagnostics**: Get errors and warnings for a file\n- **initialize_workspace**: Initialize LSP servers\n\n## Onboarding\n\n### Prerequisites\n\nInstall language servers for your languages:\n\n**TypeScript/JavaScript**\n```bash\nnpm install -g typescript-language-server typescript\n```\n\n**Rust**\n```bash\nrustup component add rust-analyzer\n```\n\n**Python**\n```bash\npip install pyright\n# or with pipx (recommended for isolation)\npipx install pyright\n```\n\n**Go**\n```bash\ngo install golang.org/x/tools/gopls@latest\n```\n\n**Java**\n```bash\n# macOS\nbrew install jdtls\n\n# Linux - download from https://download.eclipse.org/jdtls/snapshots/\n# Extract and add to PATH\n```\n\n**Ruby**\n```bash\ngem install solargraph\n```\n\n**C/C++**\n```bash\n# macOS\nbrew install llvm\n# or\nbrew install clangd\n\n# Linux (Debian/Ubuntu)\nsudo apt install clangd\n\n# Linux (Arch)\nsudo pacman -S clang\n```\n\n### Initialize Code Intelligence\n\nRun this slash command in your project root:\n\n```\n/code init\n```\n\nThis creates `lsp.json` configuration and starts language servers.\n\n**What you'll see:**\n```\n✓ Workspace initialization started\n\nWorkspace: /path/to/your/project\nDetected Languages: [\"python\", \"rust\", \"typescript\"]\nProject Markers: [\"Cargo.toml\", \"package.json\"]\n\nAvailable LSPs:\n○ clangd (cpp) - available\n○ gopls (go) - not installed\n◐ jdtls (java) - initializing...\n✓ pyright (python) - initialized (687ms)\n✓ rust-analyzer (rust) - initialized (488ms)\n○ solargraph (ruby) - not installed\n✓ typescript-language-server (typescript) - initialized (214ms)\n```\n\n**Status indicators:**\n- `✓` - Initialized and ready\n- `◐` - Currently initializing\n- `○ available` - Installed but not needed for detected languages\n- `○ not installed` - Not installed on your system\n\n**Restart LSP servers:**\nIf language servers shut down or become unresponsive, use `/code init -f`.\n\n**Auto-initialization:**\nAfter the first `/code init`, KIRO CLI automatically initializes code intelligence on startup when `lsp.json` exists in the workspace.\n\n**Disabling code intelligence:**\nDelete `lsp.json` from your project root to disable. Re-enable anytime with `/code init`.\n\n## Operations\n\n### search_symbols\n\nSearch for symbols by name across the workspace.\n\n**Parameters:**\n- `symbol_name` (required): Name to search for\n- `file_path`: Limit search to specific file\n- `symbol_type`: Filter by type (function, class, etc.)\n- `limit`: Max results (default 50)\n- `language`: Filter by language\n- `exact_match`: Require exact name match\n\n**Example queries:**\n```\n> Find the UserService class\n> Search for functions named \"validate\"\n> Find all classes in auth.ts\n```\n\n### find_references\n\nFind all references to a symbol at a specific position.\n\n**Parameters:**\n- `file_path` (required): File containing the symbol\n- `row` (required): Line number (1-based)\n- `column` (required): Column number (1-based)\n\n**Example queries:**\n```\n> Find all references to the symbol at line 42, column 10 in user.ts\n> Where is the function at auth.rs:15:5 used?\n```\n\n### goto_definition\n\nNavigate to where a symbol is defined.\n\n**Parameters:**\n- `file_path` (required): File containing the symbol\n- `row` (required): Line number (1-based)\n- `column` (required): Column number (1-based)\n- `show_source`: Include source code in result (default true)\n\n**Example queries:**\n```\n> Go to definition of symbol at main.ts:25:12\n> Where is the symbol at line 100, column 5 in handler.rs defined?\n```\n\n### get_document_symbols\n\nGet all symbols defined in a file.\n\n**Parameters:**\n- `file_path` (required): File to analyze\n- `top_level_only`: Only return top-level symbols\n\n**Example queries:**\n```\n> What symbols are in auth.service.ts?\n> Show me all functions in utils.py\n> List the classes in models.rs\n```\n\n### lookup_symbols\n\nLook up specific symbols by exact name.\n\n**Parameters:**\n- `symbols` (required): List of symbol names to find\n- `file_path`: Limit search to specific file\n\n**Example queries:**\n```\n> Find the symbols named \"processOrder\" and \"validateInput\"\n> Look up UserModel and AuthService\n```\n\n### rename_symbol\n\nRename a symbol across the entire codebase.\n\n**Parameters:**\n- `file_path` (required): File containing the symbol\n- `row` (required): Line number (1-based)\n- `column` (required): Column number (1-based)\n- `new_name` (required): New name for the symbol\n- `dry_run`: Preview changes without applying (default false)\n\n**Example queries:**\n```\n> Rename the symbol at user.ts:42:10 to \"fetchUserData\"\n> Dry run: rename symbol at line 15 column 5 in auth.rs to \"authenticateUser\"\n```\n\n### get_diagnostics\n\nGet errors, warnings, and hints for a file.\n\n**Parameters:**\n- `file_path` (required): File to check\n- `identifier`: Optional diagnostic identifier\n- `previous_result_id`: For incremental diagnostics\n\n**Example queries:**\n```\n> What errors are in main.ts?\n> Get diagnostics for auth.rs\n> Check handler.py for problems\n```\n\n## Usage Examples\n\n### Example 1: Find a Symbol\n\n```\n> Find the UserRepository class\n\nSearching for symbols matching: \"UserRepository\"\n\n  1. Class UserRepository at src/repositories/user.repository.ts:15:1\n```\n\n### Example 2: Find All References\n\n```\n> Find references to symbol at auth.ts line 42 column 10\n\nFinding all references at: auth.ts:42:10\n\n  1. src/auth.ts:42:10 - export function authenticate(...)\n  2. src/handlers/login.ts:15:5 - authenticate(credentials)\n  3. src/handlers/api.ts:89:12 - await authenticate(token)\n  (3 more items found)\n```\n\n### Example 3: Go to Definition\n\n```\n> Find the definition of UserService\n\nsrc/services/user.service.ts:42:1: export class UserService { ...\n```\n\n### Example 4: Get File Symbols\n\n```\n> What symbols are in auth.service.ts?\n\nGetting symbols from: auth.service.ts\n\n  1. Class AuthService at auth.service.ts:12:1\n  2. Function login at auth.service.ts:25:3\n  3. Function logout at auth.service.ts:45:3\n  4. Function validateToken at auth.service.ts:62:3\n```\n\n### Example 5: Rename with Dry Run\n\n```\n> Dry run: rename symbol at user.ts:42:10 to \"fetchUserData\"\n\nDry run: Would rename 12 occurrences in 5 files\n```\n\n### Example 6: Get Diagnostics\n\n```\n> Get diagnostics for main.ts\n\n  1. Error line 15:10: Cannot find name 'undefined_var'\n  2. Warning line 42:5: 'result' is declared but never used\n```\n\n## Custom Language Servers\n\nAdd custom language servers by editing `lsp.json` in your project root:\n\n```json\n{\n  \"languages\": {\n    \"mylang\": {\n      \"name\": \"my-language-server\",\n      \"command\": \"my-lsp-binary\",\n      \"args\": [\"--stdio\"],\n      \"file_extensions\": [\"mylang\", \"ml\"],\n      \"project_patterns\": [\"mylang.config\"],\n      \"exclude_patterns\": [\"**/build/**\"],\n      \"multi_workspace\": false,\n      \"initialization_options\": {\n        \"custom\": \"options\"\n      },\n      \"request_timeout_secs\": 60\n    }\n  }\n}\n```\n\n**Fields:**\n- `name`: Display name for the language server\n- `command`: Binary/command to execute\n- `args`: Command line arguments (usually `[\"--stdio\"]`)\n- `file_extensions`: File extensions this server handles\n- `project_patterns`: Files that indicate a project root (e.g., `package.json`)\n- `exclude_patterns`: Glob patterns to exclude from analysis\n- `multi_workspace`: Set to `true` if the LSP supports multiple workspace folders (default: `false`)\n- `initialization_options`: LSP-specific configuration passed during initialization\n- `request_timeout_secs`: Timeout in seconds for LSP requests (default: `60`)\n\nAfter editing, restart KIRO CLI to load the new configuration.\n\n## Slash Commands\n\n### `/code init`\nInitialize code intelligence in current directory.\n\n### `/code init -f`\nForce re-initialization (restart all LSP servers).\n\n### `/code status`\nShow workspace status and LSP server states.\n\n### `/code logs`\nDisplay LSP logs for troubleshooting.\n```\n/code logs                    # Show last 20 ERROR logs\n/code logs -l INFO            # Show INFO level and above\n/code logs -n 50              # Show last 50 entries\n/code logs -l DEBUG -n 100    # Show last 100 DEBUG+ logs\n/code logs -p ./lsp-logs.json # Export logs to JSON file\n```\n\n**Options:**\n- `-l, --level <LEVEL>`: Log level filter (ERROR, WARN, INFO, DEBUG, TRACE). Default: ERROR\n- `-n, --lines <N>`: Number of log lines to display. Default: 20\n- `-p, --path <PATH>`: Export logs to JSON file\n\n## Supported Languages\n\n| Language | Extensions | Server | Install Command |\n|----------|------------|--------|-----------------|\n| TypeScript/JavaScript | `.ts`, `.js`, `.tsx`, `.jsx` | `typescript-language-server` | `npm install -g typescript-language-server typescript` |\n| Rust | `.rs` | `rust-analyzer` | `rustup component add rust-analyzer` |\n| Python | `.py` | `pyright` | `pip install pyright` |\n| Go | `.go` | `gopls` | `go install golang.org/x/tools/gopls@latest` |\n| Java | `.java` | `jdtls` | `brew install jdtls` (macOS) |\n| Ruby | `.rb` | `solargraph` | `gem install solargraph` |\n| C/C++ | `.c`, `.cpp`, `.h`, `.hpp` | `clangd` | `brew install llvm` (macOS) or `apt install clangd` (Linux) |\n\n### \"Workspace is still initializing\"\n**Cause**: LSP servers are starting up.\n**Solution**: Wait a moment and try again. If servers crashed, use `/code init -f` to restart.\n\n### LSP initialization failed\n**Solution**: Check logs for details:\n```\n/code logs -l ERROR\n```\n\n### \"No symbols found\"\n**Causes**:\n- Language server still indexing\n- File has syntax errors\n- Symbol name doesn't match\n\n**Solution**: Check file for errors, try broader search terms.\n\n### \"No definition found\"\n**Cause**: Position doesn't point to a symbol.\n**Solution**: Verify the row and column numbers point to a symbol name.\n\n## Best Practices\n\n1. **Initialize once per project** - Run `/code init` in project root\n2. **Use exact positions** - Row and column must point to the symbol\n3. **Use dry_run for renames** - Preview changes before applying\n4. **Check diagnostics first** - Syntax errors can prevent analysis\n5. **Be specific in searches** - \"UserService\" > \"user\"\n\n## Limitations\n\n- **LSP feature support** varies by language server - not all servers support every operation (e.g., some may not support rename or formatting)\n- **Large codebases** may have slow initial indexing\n\n## Related Features\n\n- **File Operations**: See [Built-in Tools](built-in-tools.md) for fs_read/fs_write\n- **Agent Configuration**: See [Agent Format](agent-format.md) for permanent trust\n\n\n--- docs/introspect-tool.md ---\n# Introspect Tool\n\nThe introspect tool provides KIRO CLI with self-awareness, automatically answering questions about KIRO CLI's features, commands, and functionality using official documentation.\n\n## How It Works\n\nThe introspect tool activates automatically when you ask KIRO CLI questions like:\n- \"How do I save conversations with KIRO CLI?\"\n- \"What experimental features does KIRO CLI have?\"\n- \"Can KIRO CLI read files?\"\n\n## What It Provides\n\n- **Command Help**: Real-time help for all slash commands (`/save`, `/load`, etc.)\n- **Documentation**: Access to README, built-in tools, experiments, and feature guides\n- **Settings**: All configuration options and how to change them\n- **GitHub Links**: Direct links to official documentation for verification\n\n## Important Limitations\n\n**Hallucination Risk**: Despite safeguards, the AI may occasionally provide inaccurate information or make assumptions. **Always verify important details** using the GitHub documentation links provided in responses.\n\n## Usage Examples\n\n```\n> How do I save conversations with KIRO CLI?\nYou can save conversations using `/save` or `/save name`.\nLoad them later with `/load`.\n\n> What experimental features does KIRO CLI have?\nKIRO CLI offers Tangent Mode and Thinking Mode. \nUse `/experiment` to enable them.\n\n> Can KIRO CLI read and write files?\nYes, KIRO CLI has fs_read, fs_write, and execute_bash tools\nfor file operations.\n```\n\n## Auto-Tangent Mode\n\nEnable automatic tangent mode for KIRO CLI help questions:\n\n```bash\nq settings introspect.tangentMode true\n```\n\nThis keeps help separate from your main conversation.\n\n## Best Practices\n\n1. **Be explicit**: Ask \"How does KIRO CLI handle files?\" not \"How do you handle files?\"\n2. **Verify information**: Check the GitHub links provided in responses\n3. **Use proper syntax**: Reference commands with `/` (e.g., `/save`)\n4. **Enable auto-tangent**: Keep help isolated from main conversations\n\n## Configuration\n\n```bash\n# Enable auto-tangent for introspect questions\nq settings introspect.tangentMode true\n```\n\n## Related Features\n\n- **Tangent Mode**: Isolate help conversations\n- **Experiments**: Enable experimental features with `/experiment`\n\n\n--- docs/todo-lists.md ---\n# TODO Management\n\nThe `/todos` command provides persistent TODO list management for KIRO CLI, allowing you to view, resume, and manage TODO lists created during chat sessions.\n\n## Getting Started\n\nTODO lists are automatically created when Q breaks down complex tasks. You can then manage these lists using the todos command:\n\n`/todos view`\n`/todos resume`\n\n## Commands\n\n#### `/todos view`\n\nDisplay and select a TODO list to view its contents, showing task descriptions and completion status.\n\nInteractive selection shows:\n- ✓ Completed lists (green checkmark)\n- ✗ In-progress lists with completion count (red X with progress)\n\n#### `/todos resume`\n\nShow an interactive menu of available TODO lists with their current progress status. Selecting a todo list will load the list back into your chat session, allowing Q to continue where it left off.\n\n#### `/clear-finished`\n\nRemove all completed TODO lists from storage. This helps clean up your workspace by removing lists where all tasks have been completed.\n\n#### `/todos delete [--all]`\n\nDelete specific TODO lists or all lists at once.\n\n`q chat todos delete` # Interactive selection to delete one list\n`q chat todos delete --all` # Delete all TODO lists\n\n**Options:**\n- `--all` - Delete all TODO lists without interactive selection\n\n## Storage\n\nTODO lists are stored locally in `.kiro/cli-todo-lists/` directory within your current working directory. Each list is saved as a JSON file with:\n\n- Unique timestamp-based ID\n- Task descriptions and completion status  \n- Context updates from completed tasks\n- Modified file paths\n- Overall list description\n\n#### Interactive Selection\n\nAll commands use interactive selection allowing you to:\n- Navigate with arrow keys\n- Press Enter to select\n- Press Esc to cancel\n\n## Best Practices\n\n#### Managing Lists\n\n- Use `clear-finished` regularly to remove completed lists\n- Resume lists to continue complex multi-step tasks\n- View lists to check progress without resuming\n\n#### Workflow Integration\n\n- Let Q create TODO lists for complex tasks automatically\n- Use `resume` to pick up where you left off in previous sessions\n- Check `view` to see what tasks remain before resuming work\n\n#### TODO List Storage\n\n- Lists are stored in current working directory only\n- No automatic cleanup of old lists\n- No cross-directory list sharing\n\n## Troubleshooting\n\n#### No Lists Available\n\nIf commands show \"No to-do lists available\":\n\n1. **Check directory**: Ensure you're in the directory where lists were created\n2. **Verify storage**: Look for `.kiro/cli-todo-lists/` directory\n3. **Create lists**: Use chat sessions to create new TODO lists\n\n#### Lists Not Loading\n\nIf lists exist but won't load:\n\n1. **Check permissions**: Ensure read access to `.kiro/cli-todo-lists/`\n2. **Verify format**: Lists should be valid JSON files\n3. **Check file integrity**: Corrupted files may prevent loading\n\n## `todo_list` vs. `/todos`\nThe `todo_list` tool is specifically for the model to call. The model is allowed to create TODO lists, mark tasks as complete, add/remove\ntasks, load TODO lists with a given ID (which are automatically provided when resuming TODO lists), and search for existing TODO lists.\n\nThe `/todos` command is for the user to manage existing TODO lists created by the model. The user can view, resume, and delete TODO lists\nby using the appropriate subcommand and selecting the TODO list to perform the action on.\n\n## Examples\n#### Asking Q to make a TODO list:\n```\n> Make a todo list with 3 read-only tasks.\n\n> I'll create a todo list with 3 read-only tasks for you.\n\n🛠️  Using tool: todo_list (trusted)\n ⋮ \n ● TODO:\n[ ] Review project documentation\n[ ] Check system status\n[ ] Read latest updates\n ⋮ \n ● Completed in 0.4s\n```\n\n#### Selecting a TODO list to view:\n```\n> /todos view\n\n? Select a to-do list to view: ›\n❯ ✗ Unfinished todo list (0/3)\n  ✔ Completed todo list (3/3)\n```\n\n#### Resuming a TODO list (after selecting):\n```\n> /todos resume\n\n⟳ Resuming: Read-only tasks for information gathering\n\n🛠️  Using tool: todo_list (trusted)\n ⋮ \n ● TODO:\n[x] Review project documentation\n[ ] Check system status\n[ ] Read latest updates\n ⋮ \n ● Completed in 0.1s\n ```\n\n\n\n\n\n\n--- docs/hooks.md ---\n# Hooks\n\nHooks allow you to execute custom commands at specific points during agent lifecycle and tool execution. This enables security validation, logging, formatting, context gathering, and other custom behaviors.\n\n## Defining Hooks\n\nHooks are defined in the agent configuration file. See the [agent format documentation](agent-format.md#hooks-field) for the complete syntax and examples.\n\n## Hook Event\n\nHooks receive hook event in JSON format via STDIN:\n\n```json\n{\n  \"hook_event_name\": \"agentSpawn\",\n  \"cwd\": \"/current/working/directory\"\n}\n```\n\nFor tool-related hooks, additional fields are included:\n- `tool_name`: Name of the tool being executed\n- `tool_input`: Tool-specific parameters (see individual tool documentation)\n- `tool_response`: Tool execution results (PostToolUse only)\n\n## Hook Output\n\n- **Exit code 0**: Hook succeeded. STDOUT is captured but not shown to user.\n- **Exit code 2**: (PreToolUse only) Block tool execution. STDERR is returned to the LLM.\n- **Other exit codes**: Hook failed. STDERR is shown as warning to user.\n\n## Tool Matching\n\nUse the `matcher` field to specify which tools the hook applies to:\n\n### Examples\n- `\"fs_write\"` - Exact match for built-in tools\n- `\"fs_*\"` - Wildcard pattern for built-in tools\n- `\"@git\"` - All tools from git MCP server\n- `\"@git/status\"` - Specific tool from git MCP server\n- `\"*\"` - All tools (built-in and MCP)\n- `\"@builtin\"` - All built-in tools only\n- No matcher - Applies to all tools\n\nFor complete tool reference format, see [agent format documentation](agent-format.md#tools-field).\n\n## Hook Types\n\n### AgentSpawn\n\nRuns when agent is activated. No tool context provided.\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"agentSpawn\",\n  \"cwd\": \"/current/working/directory\"\n}\n```\n\n**Exit Code Behavior:**\n- **0**: Hook succeeded, STDOUT is added to agent's context\n- **Other**: Show STDERR warning to user\n\n### UserPromptSubmit\n\nRuns when user submits a prompt. Output is added to conversation context.\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"userPromptSubmit\",\n  \"cwd\": \"/current/working/directory\",\n  \"prompt\": \"user's input prompt\"\n}\n```\n\n**Exit Code Behavior:**\n- **0**: Hook succeeded, STDOUT is added to agent's context\n- **Other**: Show STDERR warning to user\n\n### PreToolUse\n\nRuns before tool execution. Can validate and block tool usage.\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"preToolUse\",\n  \"cwd\": \"/current/working/directory\",\n  \"tool_name\": \"fs_read\",\n  \"tool_input\": {\n    \"operations\": [\n      {\n        \"mode\": \"Line\",\n        \"path\": \"/current/working/directory/docs/hooks.md\"\n      }\n    ]\n  }\n}\n```\n\n**Exit Code Behavior:**\n- **0**: Allow tool execution.\n- **2**: Block tool execution, return STDERR to LLM.\n- **Other**: Show STDERR warning to user, allow tool execution.\n\n### PostToolUse\n\nRuns after tool execution with access to tool results.\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"postToolUse\",\n  \"cwd\": \"/current/working/directory\",\n  \"tool_name\": \"fs_read\",\n  \"tool_input\": {\n    \"operations\": [\n      {\n        \"mode\": \"Line\",\n        \"path\": \"/current/working/directory/docs/hooks.md\"\n      }\n    ]\n  },\n  \"tool_response\": {\n    \"success\": true,\n    \"result\": [\"# Hooks\\n\\nHooks allow you to execute...\"]\n  }\n}\n```\n\n**Exit Code Behavior:**\n- **0**: Hook succeeded.\n- **Other**: Show STDERR warning to user. Tool already ran.\n\n### Stop\n\nRuns when the assistant finishes responding to the user (at the end of each turn). \nThis is useful for running post-processing tasks like code compilation, testing, formatting, \nor cleanup after the assistant's response.\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"stop\",\n  \"cwd\": \"/current/working/directory\"\n}\n```\n\n**Exit Code Behavior:**\n- **0**: Hook succeeded.\n- **Other**: Show STDERR warning to user.\n\n**Note**: Stop hooks do not use matchers since they don't relate to specific tools.\n\n### MCP Example\n\nFor MCP tools, the tool name includes the full namespaced format including the MCP Server name:\n\n**Hook Event**\n```json\n{\n  \"hook_event_name\": \"preToolUse\",\n  \"cwd\": \"/current/working/directory\",\n  \"tool_name\": \"@postgres/query\",\n  \"tool_input\": {\n    \"sql\": \"SELECT * FROM orders LIMIT 10;\"\n  }\n}\n```\n\n## Timeout\n\nDefault timeout is 30 seconds (30,000ms). Configure with `timeout_ms` field.\n\n## Caching\n\nSuccessful hook results are cached based on `cache_ttl_seconds`:\n- `0`: No caching (default)\n- `> 0`: Cache successful results for specified seconds\n- AgentSpawn hooks are never cached\n\n--- docs/knowledge-management.md ---\n# Knowledge Management\n\nThe /knowledge command provides persistent knowledge base functionality for KIRO CLI, allowing you to store, search, and manage contextual information that persists across chat sessions.\n\n> [!NOTE]\n> This is a beta feature that must be enabled before use.\n\n## Getting Started\n\nEnable the Knowledge Feature\n\nThe knowledge feature is experimental and disabled by default. Enable it with:\n\n`q settings chat.enableKnowledge true`\n\n## Basic Usage\n\nOnce enabled, you can use `/knowledge` commands within your chat session:\n\n```bash\n/knowledge add --name myproject --path /path/to/project\n/knowledge show\n```\n\n## Commands\n\n#### `/knowledge show`\n\nDisplay all entries in your knowledge base with detailed information including creation dates, item counts, and persistence status. Also shows any active background indexing operations with progress and ETA information.\n\nThis unified command replaces the previous separate `/knowledge status` command, providing a complete view of both your stored knowledge and ongoing operations in one place.\n\n#### `/knowledge add --name <name> --path <path> [--include pattern] [--exclude pattern] [--index-type Fast|Best]`\n\nAdd files or directories to your knowledge base. The system will recursively index all supported files in directories.\n\n**Required Parameters:**\n- `--name` or `-n`: A descriptive name for the knowledge entry\n- `--path` or `-p`: Path to the file or directory to index\n\n**Examples:**\n```bash\n/knowledge add --name \"project-docs\" --path /path/to/documentation\n/knowledge add -n \"config-files\" -p /path/to/config.json\n/knowledge add --name \"fast-search\" --path /path/to/logs --index-type Fast\n/knowledge add -n \"semantic-search\" -p /path/to/docs --index-type Best\n```\n\n**Index Types**\n\nChoose the indexing approach that best fits your needs:\n\n- **`--index-type Fast`** (Lexical - BM25): \n  - ✅ **Lightning-fast indexing** - processes files quickly\n  - ✅ **Instant search** - keyword-based search with immediate results\n  - ✅ **Low resource usage** - minimal CPU and memory requirements\n  - ✅ **Perfect for logs, configs, and large codebases**\n  - ❌ Less intelligent - requires exact keyword matches\n\n- **`--index-type Best`** (Semantic - all-MiniLM-L6-v2):\n  - ✅ **Intelligent search** - understands context and meaning\n  - ✅ **Natural language queries** - search with full sentences\n  - ✅ **Finds related concepts** - even without exact keyword matches\n  - ✅ **Perfect for documentation, research, and complex content**\n  - ❌ Slower indexing - requires AI model processing\n  - ❌ Higher resource usage - more CPU and memory intensive\n\n**When to Use Each Type:**\n\n| Use Case | Recommended Type | Why |\n|----------|------------------|-----|\n| Log files, error messages | `Fast` | Quick keyword searches, large volumes |\n| Configuration files | `Fast` | Exact parameter/value lookups |\n| Large codebases | `Fast` | Fast symbol and function searches |\n| Documentation | `Best` | Natural language understanding |\n| Research papers | `Best` | Concept-based searching |\n| Mixed content | `Best` | Better overall search experience |\n\n**Default Behavior:**\n\nIf you don't specify `--index-type`, the system uses your configured default:\n\n```bash\n# Set your preferred default\nq settings knowledge.indexType Fast   # or Best\n\n# This will use your default setting\n/knowledge add -n \"my-project\" -p /path/to/project\n```\n\n**Default Pattern Behavior**\n\nWhen you don't specify `--include` or `--exclude` patterns, the system uses your configured default patterns:\n\n- If no patterns are specified and no defaults are configured, all supported files are indexed\n- Default include patterns apply when no `--include` is specified\n- Default exclude patterns apply when no `--exclude` is specified\n- Explicit patterns always override defaults\n\nExample with defaults configured:\n```bash\nq settings knowledge.defaultIncludePatterns '[\"**/*.rs\", \"**/*.py\"]'\nq settings knowledge.defaultExcludePatterns '[\"target/**\", \"__pycache__/**\"]'\n\n# This will use the default patterns\n/knowledge add -n \"my-project\" -p /path/to/project\n\n# This will override defaults with explicit patterns\n/knowledge add -n \"docs-only\" -p /path/to/project --include \"**/*.md\"\n```\n\n**New: Pattern Filtering**\n\nYou can now control which files are indexed using include and exclude patterns:\n\n`/knowledge add -n \"rust-code\" -p /path/to/project --include \"*.rs\" --exclude \"target/**\"`\n`/knowledge add -n \"docs\" -p /path/to/project --include \"**/*.md\" --include \"**/*.txt\" --exclude \"node_modules/**\"`\n\nPattern examples:\n- `*.rs` - All Rust files in all directories recursively (equivalent to `**/*.rs`)\n- `**/*.py` - All Python files recursively\n- `target/**` - Everything in target directory\n- `node_modules/**` - Everything in node_modules directory\n\nSupported file types (expanded):\n\n- Text files: .txt, .log, .rtf, .tex, .rst\n- Markdown: .md, .markdown, .mdx (now supported!)\n- JSON: .json (now treated as text for better searchability)\n- Configuration: .ini, .conf, .cfg, .properties, .env\n- Data files: .csv, .tsv\n- Web formats: .svg (text-based)\n- Code files: .rs, .py, .js, .jsx, .ts, .tsx, .java, .c, .cpp, .h, .hpp, .go, .rb, .php, .swift, .kt, .kts, .cs, .sh, .bash, .zsh, .html, .htm, .xml, .css, .scss, .sass, .less, .sql, .yaml, .yml, .toml\n- Special files: Dockerfile, Makefile, LICENSE, CHANGELOG, README (files without extensions)\n\n> Important: Unsupported files are indexed without text content extraction.\n\n#### `/knowledge remove <identifier>`\n\nRemove entries from your knowledge base. You can remove by name, path, or context ID.\n\n`/knowledge remove \"project-docs\"` # Remove by name\n`/knowledge remove /path/to/old/project` # Remove by path\n\n#### `/knowledge update <path>`\n\nUpdate an existing knowledge base entry with new content from the specified path. The original include/exclude patterns are preserved during updates.\n\n`/knowledge update /path/to/updated/project`\n\n#### `/knowledge clear`\n\nRemove all entries from your knowledge base. This action requires confirmation and cannot be undone.\n\nYou'll be prompted to confirm:\n\n> ⚠️ This will remove ALL knowledge base entries. Are you sure? (y/N):\n\n#### `/knowledge cancel [operation_id]`\n\nCancel background operations. You can cancel a specific operation by ID or all operations if no ID is provided.\n\n`/knowledge cancel abc12345 # Cancel specific operation`\n`/knowledge cancel all # Cancel all operations`\n\n## Configuration\n\nConfigure knowledge base behavior:\n\n`q settings knowledge.maxFiles 10000` # Maximum files per knowledge base\n`q settings knowledge.chunkSize 1024` # Text chunk size for processing\n`q settings knowledge.chunkOverlap 256` # Overlap between chunks\n`q settings knowledge.indexType Fast` # Default index type (Fast or Best)\n`q settings knowledge.defaultIncludePatterns '[\"**/*.rs\", \"**/*.md\"]'` # Default include patterns\n`q settings knowledge.defaultExcludePatterns '[\"target/**\", \"node_modules/**\"]'` # Default exclude patterns\n\n## Agent-Specific Knowledge Bases\n\n### Isolated Knowledge Storage\n\nEach agent maintains its own isolated knowledge base, ensuring that knowledge contexts are scoped to the specific agent you're working with. This provides better organization and prevents knowledge conflicts between different agents.\n\n### Folder Structure\n\nKnowledge bases are stored in the following directory structure:\n\n```\n~/.aws/amazonq/knowledge_bases/\n├── q_cli_default/          # Default agent knowledge base\n│   ├── contexts.json       # Metadata for all contexts\n│   ├── context-id-1/       # Individual context storage\n│   │   ├── data.json       # Semantic search data\n│   │   └── bm25_data.json  # BM25 search data (if using Fast index)\n│   └── context-id-2/\n│       ├── data.json\n│       └── bm25_data.json\n├── my-custom-agent_<alphanumeric-code>/        # Custom agent knowledge base\n│   ├── contexts.json\n│   ├── context-id-3/\n│   │   └── data.json\n│   └── context-id-4/\n│       └── data.json\n└── another-agent_<alphanumeric-code>/          # Another agent's knowledge base\n    ├── contexts.json\n    └── context-id-5/\n        └── data.json\n```\n\n### How Agent Isolation Works\n\n- **Automatic Scoping**: When you use `/knowledge` commands, they automatically operate on the current agent's knowledge base\n- **No Cross-Agent Access**: Agent A cannot access or search knowledge contexts created by Agent B\n- **Independent Configuration**: Each agent can have different knowledge base settings and contexts\n- **Migration Support**: Legacy knowledge bases are automatically migrated to the default agent on first use\n\n### Agent Switching\n\nWhen you switch between agents, your knowledge commands will automatically work with that agent's specific knowledge base:\n\n```bash\n# Working with default agent\n/knowledge add -n \"project-docs\" -p /path/to/docs\n\n# Switch to custom agent\nq chat --agent my-custom-agent\n\n# This creates a separate knowledge base for my-custom-agent\n/knowledge add -n \"agent-docs\" -p /path/to/agent/docs\n\n# Switch back to default\nq chat\n\n# Only sees the original project-docs, not agent-specific-docs\n/knowledge show\n```\n\n### Auto-Sync with Agent Resources\n\nKnowledge bases can be managed in two ways:\n\n1. **Manual Management** (via `/knowledge add`): Persistent across all agent schema changes\n2. **Agent Schema Resources** (via agent config): Auto-synced with agent configuration\n\n#### How Auto-Sync Works\n\nWhen you define knowledge base resources in your agent configuration, they are automatically managed:\n\n```json\n{\n  \"resources\": [\n    {\n      \"type\": \"knowledgeBase\",\n      \"source\": \"file://./docs\",\n      \"name\": \"Documentation\",\n      \"indexType\": \"best\"\n    }\n  ]\n}\n```\n\n**Auto-Sync Behavior:**\n- ✅ **Automatically added** when you start or switch to the agent\n- ✅ **Automatically removed** when you remove them from the agent config\n- ✅ **Automatically updated** when you modify the resource configuration\n- ✅ **Agent-specific** - only affects the current agent's knowledge base\n\n#### Agent Resource Schema\n\n| Field | Required | Type | Description |\n|-------|----------|------|-------------|\n| `type` | Yes | string | Must be `\"knowledgeBase\"` |\n| `source` | Yes | string | Path to the resource (must start with `file://`) |\n| `name` | No | string | Display name for the resource |\n| `description` | No | string | Human-readable description |\n| `indexType` | No | string | Embedding quality: `\"fast\"` or `\"best\"` (default: `\"best\"`) |\n| `include` | No | array of strings | Glob patterns for files to include (e.g., `[\"**/*.md\", \"**/*.py\"]`) |\n| `exclude` | No | array of strings | Glob patterns for files to exclude (e.g., `[\"**/node_modules/**\", \"**/target/**\"]`) |\n| `autoUpdate` | No | boolean | Auto-update the knowledge base on agent load/switch (default: `false`) |\n\n#### Examples\n\n**Basic knowledge base:**\n```json\n{\n  \"type\": \"knowledgeBase\",\n  \"source\": \"file://./docs\",\n  \"name\": \"Documentation\"\n}\n```\n\n**With file filters:**\n```json\n{\n  \"type\": \"knowledgeBase\",\n  \"source\": \"file://./src\",\n  \"name\": \"Source Code\",\n  \"include\": [\"**/*.rs\", \"**/*.toml\"],\n  \"exclude\": [\"**/target/**\"]\n}\n```\n\n**With auto-update:**\n```json\n{\n  \"type\": \"knowledgeBase\",\n  \"source\": \"file://./docs\",\n  \"name\": \"API Docs\",\n  \"indexType\": \"best\",\n  \"autoUpdate\": true\n}\n```\n\n**Complete example:**\n```json\n{\n  \"resources\": [\n    \"file://README.md\",\n    {\n      \"type\": \"knowledgeBase\",\n      \"source\": \"file://./docs\",\n      \"name\": \"Documentation\",\n      \"description\": \"Project documentation and guides\",\n      \"indexType\": \"best\",\n      \"include\": [\"**/*.md\"],\n      \"exclude\": [\"**/draft/**\"],\n      \"autoUpdate\": true\n    }\n  ]\n}\n```\n\n#### Persistence Guarantee\n\nKnowledge bases added via `/knowledge add` are persistent within the agent's scope:\n\n```bash\n# Add a knowledge base manually to current agent\n/knowledge add -n \"my-docs\" -p /path/to/docs\n\n# This knowledge base persists for this agent even if:\n# - You modify the agent's resources field\n# - You remove all resources from the agent config\n# - You restart the CLI\n# - You switch to another agent and back\n```\n\n**Agent schema resources are auto-managed:**\n\n```json\n// Add this to your agent config\n{\n  \"resources\": [\n    {\n      \"type\": \"knowledgeBase\",\n      \"source\": \"file://./project\",\n      \"name\": \"Project Files\"\n    }\n  ]\n}\n\n// This resource is automatically:\n// - Indexed when the agent loads\n// - Removed if you delete it from the config\n// - Updated if you change the configuration\n```\n\n#### Identifying Auto-Synced Resources\n\nYou can identify which knowledge bases are auto-synced by checking the `auto_sync` field:\n\n```bash\n/knowledge show\n```\n\nOutput:\n```json\n{\n  \"context-id-1\": {\n    \"name\": \"Documentation\",\n    \"auto_sync\": true,    // ← Auto-synced from agent schema\n    ...\n  },\n  \"context-id-2\": {\n    \"name\": \"my-docs\",\n    \"auto_sync\": false,   // ← Manually added, persists independently\n    ...\n  }\n}\n```\n\n#### Best Practices\n\n- **Use agent resources** for project-specific knowledge that should be automatically synced with the agent\n- **Use `/knowledge add`** for manual knowledge base management without modifying agent config files\n- **Mix both approaches** for maximum flexibility - agent-managed resources + manually added knowledge bases\n\n#### Auto-Update Feature\n\nThe `autoUpdate` field controls whether a knowledge base is automatically re-indexed when you load or switch to an agent:\n\n**With `autoUpdate: true`:**\n```json\n{\n  \"resources\": [\n    {\n      \"type\": \"knowledgeBase\",\n      \"source\": \"file://./docs\",\n      \"name\": \"Documentation\",\n      \"autoUpdate\": true\n    }\n  ]\n}\n```\n- Knowledge base is re-indexed every time you start or switch to this agent\n- Ensures the knowledge base always reflects the latest file changes\n- Useful for actively changing documentation or code\n\n**With `autoUpdate: false` (default):**\n```json\n{\n  \"resources\": [\n    {\n      \"type\": \"knowledgeBase\",\n      \"source\": \"file://./docs\",\n      \"name\": \"Documentation\"\n    }\n  ]\n}\n```\n- Knowledge base is indexed once when first added\n- Not automatically updated on agent load/switch\n- Use `/knowledge update` to manually refresh when needed\n- Better for stable documentation or large codebases\n\n## How It Works\n\n#### Indexing Process\n\nWhen you add content to the knowledge base:\n\n1. **Pattern Filtering**: Files are filtered based on include/exclude patterns (if specified)\n2. **File Discovery**: The system recursively scans directories for supported file types\n3. **Content Extraction**: Text content is extracted from each supported file\n4. **Chunking**: Large files are split into smaller, searchable chunks\n5. **Background Processing**: Indexing happens asynchronously in the background\n6. **Semantic Embedding**: Content is processed for semantic search capabilities\n\n#### Search Capabilities\n\nThe knowledge base uses semantic search, which means:\n\n- You can search using natural language queries\n- Results are ranked by relevance, not just keyword matching\n- Related concepts are found even if exact words don't match\n\n#### Persistence\n\n- Persistent contexts: Survive across chat sessions and CLI restarts\n- Context persistence is determined automatically based on usage patterns\n- Include/exclude patterns are stored with each context and reused during updates\n\n#### Best Practices\n\nOrganizing Your Knowledge Base\n\n- Use descriptive names when adding contexts: \"api-documentation\" instead of \"docs\"\n- Group related files in directories before adding them\n- Use include/exclude patterns to focus on relevant files\n- Regularly review and update outdated contexts\n\n#### Effective Searching\n\n- Use natural language queries: \"how to handle authentication errors using the knowledge tool\"\n- Be specific about what you're looking for: \"database connection configuration\"\n- Try different phrasings if initial searches don't return expected results\n- Prompt Q to use the tool with prompts like \"find database connection configuration using your knowledge bases\" or \"using your knowledge tools can you find how to replace your laptop\"\n\n#### Managing Large Projects\n\n- Add project directories rather than individual files when possible\n- Use include/exclude patterns to avoid indexing build artifacts: `--exclude \"target/**\" --exclude \"node_modules/**\"`\n- Use /knowledge show to monitor indexing progress for large directories\n- Consider breaking very large projects into logical sub-directories\n\n#### Pattern Filtering Best Practices\n\n- **Be specific**: Use precise patterns to avoid over-inclusion\n- **Exclude build artifacts**: Always exclude directories like `target/**`, `node_modules/**`, `.git/**`\n- **Include relevant extensions**: Focus on file types you actually need to search\n- **Test patterns**: Verify patterns match expected files before large indexing operations\n\n## Limitations\n\n#### File Type Support\n\n- Binary files are ignored during indexing\n- Very large files may be chunked, potentially splitting related content\n- Some specialized file formats may not extract content optimally\n\n#### Performance Considerations\n\n- Large directories may take significant time to index\n- Background operations are limited by concurrent processing limits\n- Search performance may vary based on knowledge base size and embedding engine\n- Pattern filtering happens during file walking, improving performance for large directories\n\n#### Storage and Persistence\n\n- No explicit storage size limits, but practical limits apply\n- No automatic cleanup of old or unused contexts\n- Clear operations are irreversible with no backup functionality\n\n## Troubleshooting\n\n#### Files Not Being Indexed\n\nIf your files aren't appearing in search results:\n\n1. **Check patterns**: Ensure your include patterns match the files you want\n2. **Verify exclude patterns**: Make sure exclude patterns aren't filtering out desired files\n3. **Check file types**: Ensure your files have supported extensions\n4. **Monitor progress**: Use /knowledge show to check if indexing is still in progress\n5. **Verify paths**: Ensure the paths you added actually exist and are accessible\n6. **Check for errors**: Look for error messages in the CLI output\n\n#### Search Not Finding Expected Results\n\nIf searches aren't returning expected results:\n\n1. **Wait for indexing**: Use /knowledge show to ensure indexing is complete\n2. **Try different queries**: Use various phrasings and keywords\n3. **Verify content**: Use /knowledge show to confirm your content was added\n4. **Check file types**: Unsupported file types won't have searchable content\n\n#### Performance Issues\n\nIf operations are slow:\n\n1. **Check operations**: Use /knowledge show to see operation progress and queue\n2. **Cancel if needed**: Use /knowledge cancel to stop problematic operations\n3. **Add smaller chunks**: Consider adding subdirectories instead of entire large projects\n4. **Use better patterns**: Exclude unnecessary files with exclude patterns\n5. **Adjust settings**: Consider lowering maxFiles or chunkSize for better performance\n\n#### Pattern Issues\n\nIf patterns aren't working as expected:\n\n1. **Test patterns**: Use simple patterns first, then add complexity\n2. **Check syntax**: Ensure glob patterns use correct syntax (`**` for recursive, `*` for single level)\n3. **Verify paths**: Make sure patterns match actual file paths in your project\n4. **Use absolute patterns**: Consider using full paths in patterns for precision\n\n\n--- changelog (from feed.json) ---\n\n## 1.22.0 (2025-12-11)\n- added: Introducing code intelligence through LSP integration - kiro.dev/docs/cli/code-intelligence/\n- added: Knowledge Index with agent schema configuration for knowledge bases and auto-indexing support\n- changed: Enhanced auto-compaction with deterministic read, write, shell and aws tool artifacts\n- fixed: Added guardrails for fs_read to avoid context overflow\n\n\n--- CONTRIBUTING.md ---\n# Contributing Guidelines\n\nThank you for your interest in contributing to KIRO CLI. Whether it's a bug report, new feature, correction, or additional\ndocumentation, we greatly value feedback and contributions from our community.\n\nPlease read through this document before submitting any issues or pull requests to ensure we have all the necessary\ninformation to effectively respond to your bug report or contribution.\n\n## Reporting Bugs/Feature Requests\n\nWe welcome you to use the GitHub issue tracker to report bugs or suggest features.\n\nWhen filing an issue, please check existing open, or recently closed, issues to make sure somebody else hasn't already\nreported the issue. Please try to include as much information as you can. Details like these are incredibly useful:\n\n- A reproducible test case or series of steps\n- The version of our code being used\n- Any modifications you've made relevant to the bug\n- Anything unusual about your environment or deployment\n\n## Contributing via Pull Requests\n\nBefore making changes around new features, please first make a feature request and get a statement from the team. This codebase moves quickly, and you work is likely to be lost if not first coordinated with us.\n\nContributions via pull requests are much appreciated. Before sending us a pull request, please ensure that:\n\n1. You are working against the latest source on the _main_ branch.\n2. You check existing open, and recently merged, pull requests to make sure someone else hasn't addressed the problem already.\n3. You open an issue to discuss any significant work - we would hate for your time to be wasted.\n\nTo send us a pull request, please:\n\n1. Fork the repository.\n2. Modify the source; please focus on the specific change you are contributing. If you also reformat all the code, it will be hard for us to focus on your change.\n3. Ensure local tests pass.\n4. Commit to your fork using clear commit messages.\n5. Send us a pull request, answering any default questions in the pull request interface.\n6. Pay attention to any automated CI failures reported in the pull request, and stay involved in the conversation.\n\nGitHub provides additional document on [forking a repository](https://help.github.com/articles/fork-a-repo/) and\n[creating a pull request](https://help.github.com/articles/creating-a-pull-request/).\n\n## Finding contributions to work on\n\nLooking at the existing issues is a great way to find something to contribute on. As our projects, by default, use the default GitHub issue labels (enhancement/bug/duplicate/help wanted/invalid/question/wontfix), looking at any 'help wanted' issues is a great place to start.\n\n## Code of Conduct\n\nThis project has adopted the [Amazon Open Source Code of Conduct](https://aws.github.io/code-of-conduct).\nFor more information see the [Code of Conduct FAQ](https://aws.github.io/code-of-conduct-faq) or contact\nopensource-codeofconduct@amazon.com with any additional questions or comments.\n\n## Security issue notifications\n\nIf you discover a potential security issue in this project we ask that you notify AWS/Amazon Security via our [vulnerability reporting page](http://aws.amazon.com/security/vulnerability-reporting/). Please do **not** create a public github issue.\n\n## Licensing\n\nThis repo is dual licensed under MIT and Apache 2.0 licenses. We will ask you to confirm the licensing of your contribution.\n\n\n--- Available Settings ---\nKIRO CLI supports these configuration settings (use `kiro-cli settings` command from terminal, NOT /settings):\n\n• telemetry.enabled - Enable/disable telemetry collection (boolean)\n• telemetryClientId - Legacy client identifier for telemetry (string)\n• codeWhisperer.shareCodeWhispererContentWithAWS - Share content with CodeWhisperer service (boolean)\n• chat.enableThinking - Enable thinking tool for complex reasoning (boolean)\n• chat.enableKnowledge - Enable knowledge base functionality (boolean)\n• chat.enableCodeIntelligence - Enable code intelligence with LSP integration (boolean)\n• knowledge.defaultIncludePatterns - Default file patterns to include in knowledge base (array)\n• knowledge.defaultExcludePatterns - Default file patterns to exclude from knowledge base (array)\n• knowledge.maxFiles - Maximum number of files for knowledge indexing (number)\n• knowledge.chunkSize - Text chunk size for knowledge processing (number)\n• knowledge.chunkOverlap - Overlap between text chunks (number)\n• knowledge.indexType - Type of knowledge index to use (string)\n• chat.skimCommandKey - Key binding for fuzzy search command (single character)\n• chat.autocompletionKey - Key binding for autocompletion hint acceptance (single character)\n• chat.enableTangentMode - Enable tangent mode feature (boolean)\n• chat.tangentModeKey - Key binding for tangent mode toggle (single character)\n• chat.delegateModeKey - Key binding for delegate command (single character)\n• introspect.tangentMode - Auto-enter tangent mode for introspect questions (boolean)\n• chat.greeting.enabled - Show greeting message on chat start (boolean)\n• api.timeout - API request timeout in seconds (number)\n• chat.editMode - Enable edit mode for chat interface (boolean)\n• chat.enableNotifications - Enable desktop notifications (boolean)\n• api.codewhisperer.service - CodeWhisperer service endpoint URL (string)\n• api.q.service - Q service endpoint URL (string)\n• mcp.initTimeout - MCP server initialization timeout (number)\n• mcp.noInteractiveTimeout - Non-interactive MCP timeout (number)\n• mcp.loadedBefore - Track previously loaded MCP servers (boolean)\n• chat.enableContextUsageIndicator - Show context usage percentage in prompt (boolean)\n• chat.defaultModel - Default AI model for conversations (string)\n• chat.disableMarkdownRendering - Disable markdown formatting in chat (boolean)\n• chat.defaultAgent - Default agent configuration (string)\n• chat.disableAutoCompaction - Disable automatic conversation summarization (boolean)\n• chat.enableHistoryHints - Show conversation history hints (boolean)\n• chat.enableTodoList - Enable the todo list feature (boolean)\n• chat.enableCheckpoint - Enable the checkpoint feature (boolean)\n• chat.enableDelegate - Enable the delegate tool for subagent management (boolean)\n• chat.uiMode - Specify UI variant to use (string)\n\nNOTE: Settings are managed via `kiro-cli settings` command from terminal, not slash commands in chat.\n\n\n--- CRITICAL INSTRUCTION ---\nYOU MUST ONLY provide information that is explicitly documented in the sections above. If specific details about any tool, feature, or command are not documented, you MUST clearly state that the information is not available in the documentation. DO NOT generate plausible-sounding information or make assumptions about undocumented features.\n\n",
                      "query_context": "How do I save and resume my sessions after I quit? What commands are available for saving and loading sessions?",
                      "recommendations": []
                    }
                  }
                ],
                "status": "Success"
              }
            ]
          }
        },
        "timestamp": null,
        "images": null
      },
      "assistant": {
        "Response": {
          "message_id": "d7d8b3e3-320c-40f1-96e2-9f4df9a130c4",
          "content": "You can save and resume your sessions using the `/save` and `/load` commands:\n\n**Saving conversations:**\n- `/save` - Save the current conversation with an auto-generated name\n- `/save <name>` - Save the current conversation with a specific name\n\n**Loading conversations:**\n- `/load` - Shows an interactive menu to select and load a previous conversation\n- `/load <name>` - Load a specific conversation by name\n\nThese commands allow you to preserve your chat history and context across different sessions. When you load a saved conversation, you'll continue exactly where you left off with all the previous context intact.\n\nThe saved conversations persist between CLI sessions, so you can quit KIRO CLI and return later to resume your work."
        }
      },
      "request_metadata": {
        "request_id": "51150f3f-8e46-462f-9060-5e2cbcac32c2",
        "message_id": "d7d8b3e3-320c-40f1-96e2-9f4df9a130c4",
        "request_start_timestamp_ms": 1767024484624,
        "stream_end_timestamp_ms": 1767024489783,
        "time_to_first_chunk": {
          "secs": 3,
          "nanos": 369451394
        },
        "time_between_chunks": [
          {
            "secs": 0,
            "nanos": 16562
          },
          {
            "secs": 0,
            "nanos": 2114
          },
          {
            "secs": 0,
            "nanos": 3006
          },
          {
            "secs": 0,
            "nanos": 393342
          },
          {
            "secs": 0,
            "nanos": 4474357
          },
          {
            "secs": 0,
            "nanos": 3203907
          },
          {
            "secs": 0,
            "nanos": 1324624
          },
          {
            "secs": 0,
            "nanos": 4346602
          },
          {
            "secs": 0,
            "nanos": 15379
          },
          {
            "secs": 0,
            "nanos": 3999970
          },
          {
            "secs": 0,
            "nanos": 2320187
          },
          {
            "secs": 0,
            "nanos": 3920679
          },
          {
            "secs": 0,
            "nanos": 1666296
          },
          {
            "secs": 0,
            "nanos": 2631172
          },
          {
            "secs": 0,
            "nanos": 2179859
          },
          {
            "secs": 0,
            "nanos": 9288
          },
          {
            "secs": 0,
            "nanos": 5103540
          },
          {
            "secs": 0,
            "nanos": 18608789
          },
          {
            "secs": 0,
            "nanos": 9449452
          },
          {
            "secs": 0,
            "nanos": 32022471
          },
          {
            "secs": 0,
            "nanos": 31634940
          },
          {
            "secs": 0,
            "nanos": 30910595
          },
          {
            "secs": 0,
            "nanos": 33264056
          },
          {
            "secs": 0,
            "nanos": 32573516
          },
          {
            "secs": 0,
            "nanos": 29874423
          },
          {
            "secs": 0,
            "nanos": 37272623
          },
          {
            "secs": 0,
            "nanos": 32333156
          },
          {
            "secs": 0,
            "nanos": 27671521
          },
          {
            "secs": 0,
            "nanos": 35230628
          },
          {
            "secs": 0,
            "nanos": 33174404
          },
          {
            "secs": 0,
            "nanos": 30306210
          },
          {
            "secs": 0,
            "nanos": 32030086
          },
          {
            "secs": 0,
            "nanos": 29947053
          },
          {
            "secs": 0,
            "nanos": 32052079
          },
          {
            "secs": 0,
            "nanos": 30516802
          },
          {
            "secs": 0,
            "nanos": 32354617
          },
          {
            "secs": 0,
            "nanos": 31206602
          },
          {
            "secs": 0,
            "nanos": 31864721
          },
          {
            "secs": 0,
            "nanos": 38536680
          },
          {
            "secs": 0,
            "nanos": 37414875
          },
          {
            "secs": 0,
            "nanos": 30902831
          },
          {
            "secs": 0,
            "nanos": 11771673
          },
          {
            "secs": 0,
            "nanos": 15410
          },
          {
            "secs": 0,
            "nanos": 19457
          },
          {
            "secs": 0,
            "nanos": 16111
          },
          {
            "secs": 0,
            "nanos": 15670
          },
          {
            "secs": 0,
            "nanos": 84102182
          },
          {
            "secs": 0,
            "nanos": 113839464
          },
          {
            "secs": 0,
            "nanos": 73645925
          },
          {
            "secs": 0,
            "nanos": 6350365
          },
          {
            "secs": 0,
            "nanos": 10741
          },
          {
            "secs": 0,
            "nanos": 688257
          },
          {
            "secs": 0,
            "nanos": 49425
          },
          {
            "secs": 0,
            "nanos": 18535
          },
          {
            "secs": 0,
            "nanos": 30368
          },
          {
            "secs": 0,
            "nanos": 17023
          },
          {
            "secs": 0,
            "nanos": 17534
          },
          {
            "secs": 0,
            "nanos": 18054
          },
          {
            "secs": 0,
            "nanos": 19207
          },
          {
            "secs": 0,
            "nanos": 17072
          },
          {
            "secs": 0,
            "nanos": 19397
          },
          {
            "secs": 0,
            "nanos": 6672
          }
        ],
        "user_prompt_length": 0,
        "response_size": 739,
        "chat_conversation_type": "NotToolUse",
        "tool_use_ids_and_names": [],
        "model_id": "auto",
        "message_meta_tags": []
      }
    }
  ],
  "valid_history_range": [
    0,
    2
  ],
  "transcript": [
    "> /save",
    "> /save .",
    "> how do i save and resume my sessioin s after i quit ",
    "\n[Tool uses: introspect]",
    "You can save and resume your sessions using the `/save` and `/load` commands:\n\n**Saving conversations:**\n- `/save` - Save the current conversation with an auto-generated name\n- `/save <name>` - Save the current conversation with a specific name\n\n**Loading conversations:**\n- `/load` - Shows an interactive menu to select and load a previous conversation\n- `/load <name>` - Load a specific conversation by name\n\nThese commands allow you to preserve your chat history and context across different sessions. When you load a saved conversation, you'll continue exactly where you left off with all the previous context intact.\n\nThe saved conversations persist between CLI sessions, so you can quit KIRO CLI and return later to resume your work.\n[Tool uses: none]",
    "> /save backstage.io"
  ],
  "tools": {
    "native___": [
      {
        "ToolSpecification": {
          "name": "introspect",
          "description": "ALWAYS use this tool when users ask ANY question about Q CLI itself, its capabilities, features, commands, or functionality. This includes questions like 'Can you...', 'Do you have...', 'How do I...', 'What can you do...', or any question about Q's abilities. When mentioning commands in your response, always prefix them with '/' (e.g., '/save', '/load', '/context'). CRITICAL: Only provide information explicitly documented in Q CLI documentation. If details about any tool, feature, or command are not documented, clearly state the information is not available rather than generating assumptions.",
          "input_schema": {
            "json": {
              "properties": {
                "query": {
                  "type": "string",
                  "description": "The user's question about Q CLI usage, features, or capabilities"
                }
              },
              "required": [],
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "use_aws",
          "description": "Make an AWS CLI api call with the specified service, operation, and parameters. All arguments MUST conform to the AWS CLI specification. Should the output of the invocation indicate a malformed command, invoke help to obtain the the correct command.",
          "input_schema": {
            "json": {
              "type": "object",
              "properties": {
                "parameters": {
                  "description": "The parameters for the operation. The parameter keys MUST conform to the AWS CLI specification. You should prefer to use JSON Syntax over shorthand syntax wherever possible. For parameters that are booleans, prioritize using flags with no value. Denote these flags with flag names as key and an empty string as their value. You should also prefer kebab case.",
                  "type": "object"
                },
                "label": {
                  "description": "Human readable description of the api that is being called.",
                  "type": "string"
                },
                "region": {
                  "type": "string",
                  "description": "Region name for calling the operation on AWS."
                },
                "service_name": {
                  "description": "The name of the AWS service. If you want to query s3, you should use s3api if possible. Must not start with a dash (-).",
                  "pattern": "^[^-].*",
                  "type": "string"
                },
                "profile_name": {
                  "type": "string",
                  "description": "Optional: AWS profile name to use from ~/.aws/credentials. Defaults to default profile if not specified."
                },
                "operation_name": {
                  "description": "The name of the operation to perform.",
                  "type": "string"
                }
              },
              "required": [
                "region",
                "service_name",
                "operation_name",
                "label"
              ]
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "report_issue",
          "description": "Opens the browser to a pre-filled gh (GitHub) issue template to report chat issues, bugs, or feature requests. Pre-filled information includes the conversation transcript, chat context, and chat request IDs from the service.",
          "input_schema": {
            "json": {
              "properties": {
                "actual_behavior": {
                  "description": "Optional: The actual chat behavior that happened and demonstrates the issue or lack of a feature.",
                  "type": "string"
                },
                "expected_behavior": {
                  "description": "Optional: The expected chat behavior or action that did not happen.",
                  "type": "string"
                },
                "steps_to_reproduce": {
                  "description": "Optional: Previous user chat requests or steps that were taken that may have resulted in the issue or error response.",
                  "type": "string"
                },
                "title": {
                  "description": "The title of the GitHub issue.",
                  "type": "string"
                }
              },
              "type": "object",
              "required": [
                "title"
              ]
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "execute_bash",
          "description": "Execute the specified bash command.",
          "input_schema": {
            "json": {
              "properties": {
                "command": {
                  "type": "string",
                  "description": "Bash command to execute"
                },
                "summary": {
                  "description": "A brief explanation of what the command does",
                  "type": "string"
                }
              },
              "required": [
                "command"
              ],
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "web_fetch",
          "description": "Fetch and extract content from a specific URL. Supports three modes: 'selective' (default, extracts relevant sections around search terms), 'truncated' (first 8000 chars), 'full' (complete content). Use 'selective' mode to read specific parts of a page multiple times without filling context. Provide 'search_terms' in selective mode to find relevant sections (e.g., 'pricing', 'installation').",
          "input_schema": {
            "json": {
              "properties": {
                "mode": {
                  "description": "Extraction mode: 'selective' for smart extraction (default), 'truncated' for first 8000 chars, 'full' for complete content",
                  "type": "string",
                  "enum": [
                    "selective",
                    "truncated",
                    "full"
                  ]
                },
                "url": {
                  "description": "URL to fetch content from",
                  "type": "string"
                },
                "search_terms": {
                  "type": "string",
                  "description": "Optional: Keywords to find in selective mode (e.g., 'pricing cost', 'installation setup'). Returns ~10 lines before and after matches. If not provided, returns beginning of page."
                }
              },
              "required": [
                "url"
              ],
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "fs_write",
          "description": "A tool for creating and editing files\n * The `create` command will override the file at `path` if it already exists as a file, and otherwise create a new file\n * The `append` command will add content to the end of an existing file, automatically adding a newline if the file doesn't end with one. The file must exist.\n Notes for using the `str_replace` command:\n * The `old_str` parameter should match EXACTLY one or more consecutive lines from the original file. Be mindful of whitespaces!\n * If the `old_str` parameter is not unique in the file, the replacement will not be performed. Make sure to include enough context in `old_str` to make it unique\n * The `new_str` parameter should contain the edited lines that should replace the `old_str`.",
          "input_schema": {
            "json": {
              "type": "object",
              "required": [
                "command",
                "path"
              ],
              "properties": {
                "file_text": {
                  "description": "Required parameter of `create` command, with the content of the file to be created.",
                  "type": "string"
                },
                "insert_line": {
                  "description": "Required parameter of `insert` command. The `new_str` will be inserted AFTER the line `insert_line` of `path`.",
                  "type": "integer"
                },
                "command": {
                  "description": "The commands to run. Allowed options are: `create`, `str_replace`, `insert`, `append`.",
                  "enum": [
                    "create",
                    "str_replace",
                    "insert",
                    "append"
                  ],
                  "type": "string"
                },
                "old_str": {
                  "description": "Required parameter of `str_replace` command containing the string in `path` to replace.",
                  "type": "string"
                },
                "new_str": {
                  "description": "Required parameter of `str_replace` command containing the new string. Required parameter of `insert` command containing the string to insert. Required parameter of `append` command containing the content to append to the file.",
                  "type": "string"
                },
                "path": {
                  "type": "string",
                  "description": "Absolute path to file or directory, e.g. `/repo/file.py` or `/repo`."
                },
                "summary": {
                  "description": "A brief explanation of what the file change does or why it's being made.",
                  "type": "string"
                }
              }
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "todo_list",
          "description": "A tool for creating a TODO list and keeping track of tasks. This tool should be requested EVERY time the user gives you a task that will take multiple steps. A TODO list should be made BEFORE executing any steps. Steps should be marked off AS YOU COMPLETE THEM. DO NOT display your own tasks or todo list AT ANY POINT; this is done for you. Complete the tasks in the same order that you provide them. If the user tells you to skip a step, DO NOT mark it as completed.",
          "input_schema": {
            "json": {
              "required": [
                "command"
              ],
              "properties": {
                "context_update": {
                  "description": "Required parameter of `complete` command containing important task context. Use this command to track important information about the task AND information about files you have read.",
                  "type": "string"
                },
                "command": {
                  "enum": [
                    "create",
                    "complete",
                    "load",
                    "add",
                    "remove",
                    "lookup"
                  ],
                  "description": "The command to run. Allowed options are `create`, `complete`, `load`, `add`, `remove`, and `lookup`. Call `lookup` without arguments to see a list of all existing TODO list IDs.",
                  "type": "string"
                },
                "modified_files": {
                  "type": "array",
                  "description": "Optional parameter of `complete` command containing a list of paths of files that were modified during the task. This is useful for tracking file changes that are important to the task.",
                  "items": {
                    "type": "string"
                  }
                },
                "completed_indices": {
                  "description": "Required parameter of `complete` command containing the 0-INDEXED numbers of EVERY completed task. Each task should be marked as completed IMMEDIATELY after it is finished.",
                  "type": "array",
                  "items": {
                    "type": "integer"
                  }
                },
                "current_id": {
                  "type": "string",
                  "description": "Required parameter of `complete`, `add`, and `remove` commands containing the ID of the currently loaded todo list. The ID will ALWAYS be provided after every `todo_list` call after the serialized todo list state."
                },
                "load_id": {
                  "description": "Required parameter of `load` command containing ID of todo list to load",
                  "type": "string"
                },
                "new_tasks": {
                  "type": "array",
                  "items": {
                    "required": [
                      "task_description"
                    ],
                    "type": "object",
                    "properties": {
                      "task_description": {
                        "description": "The main task description",
                        "type": "string"
                      },
                      "details": {
                        "description": "Optional detailed information about the task",
                        "type": "string"
                      }
                    }
                  },
                  "description": "Required parameter of `add` command containing a list of new tasks to be added to the to-do list."
                },
                "insert_indices": {
                  "description": "Required parameter of `add` command containing a list of 0-INDEXED positions to insert the new tasks. There MUST be an index for every new task being added.",
                  "items": {
                    "type": "integer"
                  },
                  "type": "array"
                },
                "new_description": {
                  "type": "string",
                  "description": "Optional parameter of `add` and `remove` containing a new todo list description. Use this when the updated set of tasks significantly change the goal or overall procedure of the todo list."
                },
                "remove_indices": {
                  "description": "Required parameter of `remove` command containing a list of 0-INDEXED positions of tasks to remove.",
                  "items": {
                    "type": "integer"
                  },
                  "type": "array"
                },
                "tasks": {
                  "type": "array",
                  "items": {
                    "required": [
                      "task_description"
                    ],
                    "properties": {
                      "task_description": {
                        "description": "The main task description",
                        "type": "string"
                      },
                      "details": {
                        "type": "string",
                        "description": "Optional detailed information about the task"
                      }
                    },
                    "type": "object"
                  },
                  "description": "Required parameter of `create` command containing the list of DISTINCT tasks to be added to the TODO list."
                },
                "todo_list_description": {
                  "description": "Required parameter of `create` command containing a BRIEF summary of the todo list being created. The summary should be detailed enough to refer to without knowing the problem context beforehand.",
                  "type": "string"
                }
              },
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "web_search",
          "description": "WebSearch looks up information that is outside the model's training data or cannot be reliably inferred from the current codebase/context.\nTool performs basic compliance wrt content licensing and restriction.\nAs an agent you are responsible for adhering to compliance and attribution requirements.\nIMPORTANT: The snippets often contain enough information to answer questions - only use web_fetch if you need more detailed content from a specific webpage.\n\n## When to Use\n- When the user asks for current or up-to-date information (e.g., pricing, versions, technical specs) or explicitly requests a web search.\n- When verifying information that may have changed recently, or when the user provides a specific URL to inspect.\n\n## When NOT to Use\n- When the question involves basic concepts, historical facts, or well-established programming syntax/technical documentation.\n- When the topic does not require current or evolving information.\n- If the query concerns non-coding topics (e.g., news, current affairs, religion, economics, society). You must not invoke this tool.\n\nFor any code-related tasks, follow this order:\n1. Search within the repository (if tools are available) and check if it can be inferred from existing code or documentation.\n2. Use this tool only if still unresolved and the library/data is likely new/unseen.\n\n## Content Compliance Requirements\nYou MUST adhere to strict licensing restrictions and attribution requirements when using search results:\n\n### Attribution Requirements\n- ALWAYS provide inline links to original sources using format: [description](url)\n- If not possible to provide inline link, add sources at the end of file\n- Ensure attribution is visible and accessible\n\n### Verbatim Reproduction Limits\n- NEVER reproduce more than 30 consecutive words from any single source\n- Track word count per source to ensure compliance\n- Always paraphrase and summarize rather than quote directly\n- Add compliance note when the content from the source is rephrased: \"Content was rephrased for compliance with licensing restrictions\"\n\n### Content Modification Guidelines\n- You MAY paraphrase, summarize, and reformat content\n- You MUST NOT materially change the underlying substance or meaning\n- Preserve factual accuracy while condensing information\n- Avoid altering core arguments, data, or conclusions\n\n## Usage Details\n- You may rephrase user queries to improve search effectiveness\n- You can make multiple queries to gather comprehensive information\n- Consider breaking complex questions into focused searches\n- Refine queries based on initial results if needed\n\n## Output Usage\n- Prioritize latest published sources based on publishedDate\n- Prefer official documentation to blogs and news posts\n- Use domain information to assess source authority and reliability\n\n## Error Handling\n- If unable to comply with content restrictions, explain limitations to user\n- Suggest alternative approaches when content cannot be reproduced\n- Prioritize compliance over completeness when conflicts arise\n\n## Output\nThe tool returns a JSON object with a \"results\" array containing search results:\n\n{\n  \"results\": [\n    {\n      \"title\": \"Example Page Title\",\n      \"url\": \"https://example.com/page\",\n      \"snippet\": \"Brief excerpt from the page...\",\n      \"publishedDate\": \"2025-11-20T10:30:00Z\",\n      \"domain\": \"example.com\",\n      \"id\": \"unique-id-123\",\n      \"maxVerbatimWordLimit\": 30,\n      \"publicDomain\": false\n    }\n  ]\n}\n\n## UI FROM LLM (You) back to the user\nCRITICAL: Always start your response with \"Here's what I found:\" and then start from a newline.\nALWAYS end your response with a blank line followed by 'References:' and list the sources you used in sequential order [1], [2], [3], etc. with NO gaps in numbering. Format: '[N] Title - URL' one per line. Truncate long titles to 80 characters and long URLs to 100 characters, adding '...' if truncated.",
          "input_schema": {
            "json": {
              "required": [
                "query"
              ],
              "properties": {
                "query": {
                  "type": "string",
                  "description": "Search query - can be keywords, questions, or specific topics"
                }
              },
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "fs_read",
          "description": "Tool for reading files, directories and images. Always provide an 'operations' array.\n\nFor single operation: provide array with one element.\nFor batch operations: provide array with multiple elements.\n\nAvailable modes:\n- Line: Read lines from a file\n- Directory: List directory contents\n- Search: Search for patterns in files\n- Image: Read and process images\n\nExamples:\n1. Single: {\"operations\": [{\"mode\": \"Line\", \"path\": \"/file.txt\"}]}\n2. Batch: {\"operations\": [{\"mode\": \"Line\", \"path\": \"/file1.txt\"}, {\"mode\": \"Search\", \"path\": \"/file2.txt\", \"pattern\": \"test\"}]}",
          "input_schema": {
            "json": {
              "properties": {
                "operations": {
                  "items": {
                    "required": [
                      "mode"
                    ],
                    "type": "object",
                    "properties": {
                      "context_lines": {
                        "default": 2,
                        "type": "integer",
                        "description": "Number of context lines around search results (optional, for Search mode)"
                      },
                      "pattern": {
                        "type": "string",
                        "description": "Pattern to search for (required, for Search mode). Case insensitive. The pattern matching is performed per line."
                      },
                      "start_line": {
                        "type": "integer",
                        "description": "Starting line number (optional, for Line mode). A negative index represents a line number starting from the end of the file.",
                        "default": 1
                      },
                      "mode": {
                        "type": "string",
                        "enum": [
                          "Line",
                          "Directory",
                          "Search",
                          "Image"
                        ],
                        "description": "The operation mode to run in: `Line`, `Directory`, `Search`. `Line` and `Search` are only for text files, and `Directory` is only for directories. `Image` is for image files, in this mode `image_paths` is required."
                      },
                      "offset": {
                        "description": "Number of entries to skip for pagination (optional, for Directory mode). Use with max_entries to iterate through large directories. Entries are sorted by last modified time (most recent first). Default: 0",
                        "default": 0,
                        "type": "integer"
                      },
                      "path": {
                        "description": "Path to the file or directory. The path should be absolute, or otherwise start with ~ for the user's home (required for Line, Directory, Search modes).",
                        "type": "string"
                      },
                      "image_paths": {
                        "description": "List of paths to the images. This is currently supported by the Image mode.",
                        "type": "array",
                        "items": {
                          "type": "string"
                        }
                      },
                      "exclude_patterns": {
                        "items": {
                          "type": "string"
                        },
                        "description": "Glob patterns to exclude from directory listing (optional, for Directory mode). If omitted, uses defaults. If empty array [] is provided, no exclusions are applied (shows everything). If patterns are provided, they completely override the defaults. Examples: '**/target/**', '*.log'",
                        "default": [
                          "node_modules",
                          ".git",
                          "dist",
                          "build",
                          "out",
                          ".cache",
                          "target"
                        ],
                        "type": "array"
                      },
                      "end_line": {
                        "type": "integer",
                        "default": -1,
                        "description": "Ending line number (optional, for Line mode). A negative index represents a line number starting from the end of the file."
                      },
                      "depth": {
                        "type": "integer",
                        "description": "Depth of a recursive directory listing (optional, for Directory mode)",
                        "default": 0
                      },
                      "max_entries": {
                        "description": "Maximum number of entries to return (optional, for Directory mode). When limit is reached, results are truncated and metadata shows 'showing X of Y entries'. Use to prevent context window overflow. Default: 1000",
                        "default": 1000,
                        "type": "integer"
                      }
                    }
                  },
                  "type": "array",
                  "description": "Array of operations to execute. Provide one element for single operation, multiple for batch.",
                  "minItems": 1
                },
                "summary": {
                  "type": "string",
                  "description": "Optional description of the purpose of this batch operation (mainly useful for multiple operations)"
                }
              },
              "required": [
                "operations"
              ],
              "type": "object"
            }
          }
        }
      },
      {
        "ToolSpecification": {
          "name": "dummy",
          "description": "This is a dummy tool. If you are seeing this that means the tool associated with this tool call is not in the list of available tools. This could be because a wrong tool name was supplied or the list of tools has changed since the conversation has started. Do not show this when user asks you to list tools.",
          "input_schema": {
            "json": {
              "type": "object",
              "required": [],
              "properties": {}
            }
          }
        }
      }
    ]
  },
  "context_manager": {
    "max_context_files_size": 150000,
    "current_profile": "kiro_default",
    "paths": [
      "AmazonQ.md",
      "AGENTS.md",
      "README.md"
    ],
    "hooks": {}
  },
  "context_message_length": null,
  "latest_summary": null,
  "model_info": {
    "model_name": "Auto",
    "description": "Models chosen by task for optimal usage and consistent quality",
    "model_id": "auto",
    "context_window_tokens": 200000,
    "rate_multiplier": 1.0,
    "rate_unit": "credit"
  },
  "file_line_tracker": {},
  "checkpoint_manager": null,
  "mcp_enabled": true,
  "user_turn_metadata": {
    "continuation_id": "b764e7ff-4ea2-4088-a5ba-2a4ee0d08b32",
    "requests": [],
    "usage_info": []
  }
}