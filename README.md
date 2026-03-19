# DramaAdapt Skill — 网文改编漫剧剧本编排器

> 一键将网络小说改编为标准漫剧剧本的 Claude Code Skill
> 五阶段全自动工作流 · 三个人工确认节点 · 付费卡点自动设计 · 质检报告输出

---

## 效果预览

| 输入 | 输出 |
|------|------|
| 一份小说 `.txt` 文件 | 分集剧本 `scripts/ep001.md ~ ep[N].md` |
| 5000字末世网文 | 6集完整漫剧剧本（附分析报告、人物小传、大纲、质检报告） |

完整示例：[example/](./example/) 目录包含"末世游戏：我能看到隐藏提示"的全套输出文件。

---

## 环境要求

- **Claude Code CLI**（必须）→ 安装说明见 [Claude Code 文档](https://docs.anthropic.com/en/docs/claude-code)
- **Superpowers Skill 系统**（必须）→ 本 Skill 依赖 Superpowers 框架的 Skill 加载机制

---

## 安装

### 方式一：自动安装（推荐）

```bash
# 克隆仓库
git clone https://github.com/rorojiao/drama-adapt-skill.git
cd drama-adapt-skill

# 运行安装脚本（会自动复制到 ~/.claude/skills/drama-adapt/）
chmod +x install.sh
./install.sh
```

### 方式二：手动安装

```bash
# 1. 创建 Skill 目录
mkdir -p ~/.claude/skills/drama-adapt/references

# 2. 复制文件
cp skill/SKILL.md ~/.claude/skills/drama-adapt/SKILL.md
cp skill/references/script-format-guide.md ~/.claude/skills/drama-adapt/references/script-format-guide.md
```

### 验证安装

打开 Claude Code，输入以下命令，应该看到 `drama-adapt` 出现在技能列表中：

```
/skills
```

或直接测试触发：

```
改编漫剧
```

---

## 使用方法

### 基础用法（推荐新手）

```bash
# 1. 准备小说文件
mkdir my-novel && cd my-novel
cp ~/Downloads/my-novel.txt ./novel.txt  # 文件名不限，任意 .txt 文件即可

# 2. 在该目录启动 Claude Code
claude

# 3. 在 Claude Code 中运行
/drama-adapt
```

Claude 会引导你完成以下流程：

```
启动向导（3个快速问题）
    ↓
阶段1：原著分析 → analysis.md
    ↓
阶段2：人物小传 → characters.md
    ↓
[节点A] 确认人物设定
    ↓
阶段3：分集大纲 → outline.md
    ↓
[节点B] 确认分集大纲
    ↓
阶段4：逐集剧本 → scripts/ep001.md ~ ep[N].md
    ↓
[节点C] 剧本抽查
    ↓
阶段5：全文质检 → qc_report.md
    ↓
完成交付
```

---

## 启动向导说明

运行 `/drama-adapt` 后，Claude 会依次问 3 个问题：

### 问题 1：题材类型

```
1. 都市言情（甜宠/虐恋/豪门）
2. 古代言情（宫斗/穿越/仙侠言情）
3. 都市爽文（逆袭/重生/赘婿）
4. 玄幻修仙（升级/热血/战斗）
5. 悬疑推理（烧脑/反转/刑侦）
6. 末世/生存（末日/求生/变异）
7. 其他（请描述题材特征）
```

### 问题 2：剧本规格

```
1. 短季 · 30集（每集60-90秒，≈500-800字/集）← 推荐新手、试水
2. 标准季 · 60集
3. 长季 · 100集
4. 自定义
```

### 问题 3：改编策略

```
1. 忠实改编（保留原著情节）← 推荐
2. 精简改编（只保留主线爽点链）
3. 创意改编（增加原创情节）
```

---

## 3 个人工确认节点

Skill 在关键位置暂停等待你确认，防止方向跑偏：

| 节点 | 时机 | 你需要做什么 |
|------|------|-------------|
| **节点 A** | 人物小传生成后 | 确认角色设定是否符合预期 |
| **节点 B** | 分集大纲生成后 | 确认集数规划、付费卡点位置 |
| **节点 C** | 全部剧本生成后 | 抽查1-2集，确认写作质量 |

回复 `确认` 继续，或直接说修改意见让 Claude 修改后重新展示。

---

## 高级命令

```bash
/drama-adapt                  # 标准模式（推荐）
/drama-adapt --auto           # 无人值守模式（跳过所有确认节点）
/drama-adapt --from=3         # 从阶段3重跑（已有前两阶段时使用）
/drama-adapt --stage=4        # 仅重跑阶段4（逐集剧本）
/drama-adapt --ep=5           # 仅重写第5集
/drama-adapt --ep=1-10        # 重写第1-10集
```

---

## 断点续跑

项目进度保存在当前目录的 `project.json` 中。关闭 Claude Code 后，重新进入目录运行 `/drama-adapt`，会自动检测进度并从上次中断的地方继续。

---

## 输出文件说明

| 文件 | 说明 |
|------|------|
| `analysis.md` | 原著分析报告（人物表、情节节点、爽点清单、改编建议） |
| `characters.md` | 主要角色人物小传（外貌、性格、人物弧） |
| `outline.md` | 分集大纲（含免费区/付费区划分、付费卡点设计） |
| `scripts/ep001.md` | 第1集剧本（以此类推） |
| `qc_report.md` | 三轮质检报告（格式/叙事/角色，含评分） |
| `project.json` | 项目状态文件（进度存档，勿手动修改） |

---

## 漫剧剧本格式说明

生成的剧本遵循行业标准格式：

```markdown
# 第X集：[集名]

> 本集概要：...
> 预计时长：XX秒 | 场景数：X | 字数：XXX

---

## 场1-1 日/内 [场景名称]

**画面**：[视觉化场景描写]

**林远**
（皱眉，慢慢抬头）
你说的是真的？

**苏晚**
（点头，语气坚定）
我不会骗你。

---

### 【本集钩子】
> [结尾悬念]
```

**行业参数标准：**

| 参数 | 标准值 |
|------|--------|
| 单集时长 | 60-120秒 |
| 单集字数 | 500-1000字 |
| 每集场景数 | 3-6场 |
| 免费集数 | 前10集（可配置） |
| 付费卡点 | 第10集结尾 |
| 爽点密度 | 每2-3集一个主要爽点 |

---

## 完整示例

[example/](./example/) 目录包含完整的改编示例：

- **原著**：末世游戏：我能看到隐藏提示（5000字，5章）
- **题材**：末世/生存
- **规格**：6集短季（每集60-90秒，500-800字）
- **质检得分**：98.6 / 100

查看示例：

```bash
ls example/
# analysis.md  characters.md  novel.txt  outline.md  project.json  qc_report.md  scripts/

ls example/scripts/
# ep001.md  ep002.md  ep003.md  ep004.md  ep005.md  ep006.md
```

---

## 常见问题

**Q: 小说文件名叫什么都可以吗？**
A: 是的，Skill 会自动搜索当前目录下所有 `.txt` 文件。

**Q: 小说太长（>10万字）怎么办？**
A: Skill 内置分块处理策略，自动分段读取并保留上下文重叠，适用于任意长度。

**Q: 中途关掉了怎么办？**
A: 直接在原目录重新运行 `/drama-adapt`，会自动从上次中断处继续。

**Q: 想重写某一集怎么办？**
A: 运行 `/drama-adapt --ep=N`（替换 N 为集数）。

**Q: 不想每次都确认，全自动运行怎么做？**
A: 运行 `/drama-adapt --auto` 跳过所有人工节点。

---

## 项目结构

```
drama-adapt-skill/
├── README.md                          ← 本文件（使用说明）
├── install.sh                         ← 一键安装脚本
├── skill/
│   ├── SKILL.md                       ← Skill 核心文件（安装到 ~/.claude/skills/）
│   └── references/
│       └── script-format-guide.md     ← 漫剧格式行业参考规范
├── example/                           ← 完整示例项目
│   ├── novel.txt                      ← 示例原著（末世游戏）
│   ├── project.json                   ← 项目状态
│   ├── analysis.md                    ← 原著分析报告
│   ├── characters.md                  ← 人物小传
│   ├── outline.md                     ← 分集大纲
│   ├── qc_report.md                   ← 质检报告（98.6分）
│   └── scripts/
│       ├── ep001.md ~ ep006.md        ← 6集完整剧本
└── docs/
    └── design-spec.md                 ← 技术设计文档
```

---

## License

MIT — 自由使用和修改，保留原作者信息即可。
