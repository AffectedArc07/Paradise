import { useBackend } from "../../backend";
import { AnimatedNumber, Box, LabeledList, Section, Flex, Button, Tooltip } from "../../components";

export const TechwebNodeView = (properties, context) => {
  const { data, act } = useBackend(context);
  const {
    researchpoints,
    nodename,
    nodecost,
    nodedesc,
    nodeid,
    node_designs,
    node_unlocks,
    node_requirements,
    node_unlocked,
  } = data;
  return (
    <Box>
      <Section title={nodename} buttons={
        <Button content="Back" onClick={() => act('TW_back')} />
      }>
        <LabeledList>
          <LabeledList.Item label="Research Points">
            <AnimatedNumber value={researchpoints} />
          </LabeledList.Item>
        </LabeledList>
        <Flex mt={1}>
          <Flex.Item grow={1} width="30%">
            <Box bold mb={1}>
              Required Nodes
            </Box>
            <Box maxHeight={32} overflowY="auto" overflowX="hidden">
              {node_requirements.map(n => (
                <Box mt={1} key={n.id} style={{ border: "1px solid #595959", "border-radius ": "5px" }} pt={0.5} pl={0.5} pr={0.5} pb={0.5}>
                  <Button content={n.displayname} fluid onClick={() => act('TW_viewNode', { id: n.id })} selected={n.unlocked} />
                  <Button content={"Research (" + n.research_cost + " Points)"} fluid disabled={researchpoints < n.research_cost} onClick={() => act('TW_research', { id: n.id })} />
                  <Box italic>
                    {n.description}
                    <Box>
                      {n.designs.map(d => (
                        <img src={"design_" + d.id + ".png"} width="32px" title={d.name} key={d.id} />
                      ))}
                    </Box>
                  </Box>
                </Box>
              ))}
            </Box>
          </Flex.Item>
          <Flex.Item grow={1} width="40%">
            <Box bold mb={1}>
              Selected Node
            </Box>
            <Box maxHeight={32} overflowY="auto" overflowX="hidden">
              <Box mt={1} style={{ border: "1px solid #595959", "border-radius ": "5px" }} pt={0.5} pl={0.5} pr={0.5} pb={0.5}>
                <Button content={nodename} fluid selected={node_unlocked} />
                <Button content={"Research (" + nodecost + " Points)"} fluid disabled={researchpoints < nodecost} onClick={() => act('TW_research', { id: nodeid })} />
                <Box italic>
                  {nodedesc}
                  <Box>
                    {node_designs.map(d => (
                      <img src={"design_" + d.id + ".png"} width="32px" title={d.name} key={d.id} />
                    ))}
                  </Box>
                </Box>
              </Box>
            </Box>
          </Flex.Item>
          <Flex.Item grow={1} width="30%">
            <Box bold mb={1}>
              Component Of
            </Box>
            <Box maxHeight={32} overflowY="auto" overflowX="hidden">
              {node_unlocks.map(n => (
                <Box mt={1} key={n.id} style={{ border: "1px solid #595959", "border-radius ": "5px" }} pt={0.5} pl={0.5} pr={0.5} pb={0.5}>
                  <Button content={n.displayname} fluid onClick={() => act('TW_viewNode', { id: n.id })} />
                  <Button content={"Research (" + n.research_cost + " Points)"} fluid disabled />
                  <Box italic>
                    {n.description}
                    <Box>
                      {n.designs.map(d => (
                        <img src={"design_" + d.id + ".png"} width="32px" title={d.name} key={d.id} />
                      ))}
                    </Box>
                  </Box>
                </Box>
              ))}
            </Box>
          </Flex.Item>
        </Flex>
      </Section>
    </Box>
  );
};
