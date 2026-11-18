# eelab1-report-workflow

浙江大学《电子电路设计实验 I》报告的 AI 工作流。Claude Code 或 Codex 读取课程安排、讲义与模板，处理实验数据并产出 LaTeX 实验报告，用 XeLaTeX 编译归档。

## 三步开始

1. 克隆仓库，用 Claude Code / Codex 打开本目录。
2. 对 AI 说「**初始化**」。它询问姓名、学号、同组、专业，运行 `init.ps1` 注入字体，并把这些信息写进 `课程安排.md` 与所有 `report.tex`。
3. 说「转录这份记录本数据」或「写实验 01 报告」。实验日期、地点、指导老师因人而异，AI 会在用到时先问你。

> **预习提纲已随仓库提供**：`实验01–07/预习提纲.md` 全部写好，直接抄入《实验记录本》；不需要 AI 再生成，也不生成 LaTeX/PDF。

> **写报告时**：AI 先读 `讲义.pdf` 对应章节，再参考 `reference/` 中同实验报告的结构与写法；只借鉴结构，不抄文字、数据与图。

不使用 AI 也可以：手动填写 `课程安排.md` 与各 `report.tex` 的字段，运行 `init.ps1`，在实验目录执行 `latexmk -xelatex report.tex`。

## 环境要求

- Windows 10/11：`init.ps1` 从 `C:\Windows\Fonts` 复制宋体与楷体。
- TeX Live（2025 或更新），`latexmk` 在 PATH 中。
- Python 3 与 numpy/scipy/matplotlib（可选，数据处理）。
- OrCAD / PSpice（实验 03–07 仿真需要）。

## 目录结构

```
.
├── CLAUDE.md              AI 规则与完整工作流
├── 课程安排.md             7 个实验的名称与类型（日期留空，做实验时确认）
├── init.ps1               字体注入与环境检查
├── 讲义.pdf                课程讲义
├── 前言.pptx               评分权重、图表规范、提交规则
├── assets/fonts/          思源宋体 Bold（OFL）
├── 电设实验报告模板/        只读 LaTeX 模板
├── 实验01-电路定律验证/      预习提纲.md + report.tex + 数据/图/脚本
├── 实验02-一阶RC电路瞬态响应/
├── …                      实验03–07
├── reference/             自备参考报告（内容不随仓库分发）
└── .gitignore
```

每个实验目录固定为：`report.tex`、`预习提纲.md`、`config.cls`、`local-fonts/`、`data/raw/`、`data/processed/`、`figures/`、`src/`、`Rst/`。

## init.ps1 做什么

- 从 `C:\Windows\Fonts` 复制 `simsun.ttc`、`simkai.ttf` 到 7 个实验目录与模板目录的 `local-fonts/`。
- 把仓库自带的思源宋体 Bold 复制为 `simsunBold.otf`（模板的粗体字体）。
- 补建缺失的数据/图/脚本/归档目录。
- 检查 `latexmk` 与 Python 是否可用。

专有字体不随仓库分发；仓库只带 OFL 授权的思源宋体 Bold。

## 数据与提交

- `data/raw/` 只增不改：记录本照片、扫描 PDF 原件放这里。
- 转录结果写 `data/processed/*.csv`；先出核对表，用户确认后再分析。
- 归档命名：`Rst/<姓名>-<学号>-<实验名称全称>实验报告.pdf`。
- 首次报告打印 `电设实验报告模板/实验报告封面.doc` 并装订；第 2 次起只用页眉。

## 仓库不包含

- 他人参考报告（需要的同学自行获取，放 `reference/`，内容已被忽略）。
- 任何实测数据或已完成的报告。
- 课程讲义与前言 PPT 的版权归课程组，随仓库提供仅限本课程学习使用。

## 许可与致谢

- 本仓库的文档与工作流：CC BY-SA 4.0（见 `LICENSE`）。
- 报告模板 `电设实验报告模板/`：魔改自 PhilFan 与雪松 Cedar 的 CC98 模板，沿用 CC BY-SA 4.0；原作者与来源见模板内 `READM.md`。
- 思源宋体 Bold：SIL Open Font License 1.1（见 `assets/fonts/OFL.txt`）。
