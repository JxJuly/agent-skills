import { confirm, select } from '@inquirer/prompts';
import { logger } from '@july_cm/logger';
import fs from 'fs-extra';
import path from 'path';
import { fileURLToPath } from 'url';

import { Framework } from './constants';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const main = async () => {
  await select({
    message: 'Select a framework',
    choices: [{ name: 'TraeIDE', value: Framework.Trae }],
  });

  // 项目根目录
  const rootPath = process.cwd();
  // 脚手架目录
  const cliPath = path.resolve(__dirname, '..');
  const traeSkillPath = path.join(rootPath, '.trae/skills');
  const cliSkillsPath = path.join(cliPath, 'skills');

  await fs.ensureDir(traeSkillPath);

  const skills = await fs.readdir(cliSkillsPath);
  for (const skill of skills) {
    const src = path.join(cliSkillsPath, skill);
    const dest = path.join(traeSkillPath, skill);

    const exists = await fs.pathExists(dest);

    if (!exists) {
      // ✅ 不存在：直接拷贝
      await fs.copy(src, dest);
      logger.success(`copied: ${skill}`);
      continue;
    }

    // ⚠️ 已存在：询问用户
    const shouldOverwrite = await confirm({
      message: `Skill "${skill}" already exists. Overwrite?`,
      default: false,
    });

    if (!shouldOverwrite) {
      logger.info(`skipped: ${skill}`);
      continue;
    }

    // ✅ 覆盖：先删再拷贝（你要求的方式）
    await fs.remove(dest);
    await fs.copy(src, dest);

    logger.success(`overwritten: ${skill}`);
  }
};

main().catch((error) => {
  if (error instanceof Error && error.name === 'ExitPromptError') {
    logger.info('Until next time!');
  } else {
    throw error;
  }
});
