from strands import Agent
from strands.multiagent.a2a import A2AServer
from strands_tools.calculator import calculator
import importlib.metadata

# Create a Strands agent with calculator tool
strands_agent = Agent(
    name="Calculator Agent",
    description="A calculator agent that can perform basic arithmetic operations.",
    tools=[calculator],
    callback_handler=None,
)


# Get version information
try:
    strands_version = importlib.metadata.version("strands-agents")
    a2a_version = importlib.metadata.version("a2a-sdk")
    print(f"Strands version: {strands_version}")
    print(f"A2A SDK version: {a2a_version}")
except Exception as e:
    print(f"Could not determine version information: {e}")

# Create A2A server
a2a_server = A2AServer(agent=strands_agent, host="0.0.0.0", port=9000)

# Start the server
print(f"Starting A2A Server on http://0.0.0.0:9000")
a2a_server.serve()
